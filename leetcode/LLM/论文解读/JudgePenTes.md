```json
{
  "asr": {
    "text": "把音量调到二十",
    "confidence": 0.92,
    "nbest": [
      {"text": "把音量调到20", "confidence": 0.92},
      {"text": "把音量调到30", "confidence": 0.07}
    ],
    "lang": "zh-CN"
  },
  "context": {
    "current_app": "YouTube",
    "player_state": "playing",
    "parental_control": "on|off",
    "kids_mode": false,
    "recording": false,
    "network": "good|poor",
    "user_profile": {"simple_intent_whitelist": ["调音量","暂停","继续","换台"]}
  },
  "policy": {
    "redlines": ["purchase","payment","login","account_change","privacy_read","system_settings_critical"]
  },
  "fast_parse": {
    "intent": "SetVolume",
    "slots": {"level": 20},
    "confidence": 0.86,
    "novelty": 0.12,              // 越大越“新/长尾”
    "risk_tags": [],              // 模型识别出的潜在风险
    "parse_time_ms": 18
  },
  "slow_parse": {
    "intent": "SetVolume",
    "slots": {"level": 20},
    "confidence": 0.94,
    "novelty": 0.10,
    "risk_tags": [],
    "parse_time_ms": 180
  },
  "latency_budget_ms": 300       // 本轮允许决策的时间预算
}

```

```json
{
  "version": "tv-voice-routing-rubric-v0.1",
  "weights": {"A": 0.4, "B": 0.4, "C": 0.2},
  "A_Objective": [
    {
      "id": "A1_simple_whitelist",
      "desc": "意图在简单白名单内（调音量/暂停/继续/静音/换台/开关字幕等）",
      "condition": "fast_parse.intent in user_profile.simple_intent_whitelist OR slow_parse.intent in user_profile.simple_intent_whitelist"
    },
    {
      "id": "A2_slots_complete",
      "desc": "所需槽位齐全（如 SetVolume 需要 level）",
      "condition": "required_slots(fast_parse.intent) ⊆ keys(fast_parse.slots) OR required_slots(slow_parse.intent) ⊆ keys(slow_parse.slots)"
    },
    {
      "id": "A3_context_compatible",
      "desc": "当前应用/状态支持该操作（如直播源支持换台；播放器可调音量）",
      "condition": "is_supported(context.current_app, max_conf_intent(fast_parse,slow_parse))"
    }
  ],
  "B_OpSec": [
    {
      "id": "B1_redline_risk",
      "desc": "涉及购买/支付/登录/改账号/读取隐私/关键系统设置等红线",
      "condition": "intersects(policy.redlines, union(fast_parse.risk_tags, slow_parse.risk_tags))"
    },
    {
      "id": "B2_disruption_risk",
      "desc": "操作可能中断重要活动（正在录制/更新/家长控制场景）",
      "condition": "context.recording==true OR context.parental_control=='on'"
    },
    {
      "id": "B3_privacy_risk",
      "desc": "需要读取历史/联系人/账号信息且ASR置信度低",
      "condition": "('privacy_read' in policy.redlines) AND (asr.confidence < 0.85)"
    }
  ],
  "C_Tradecraft": [
    {
      "id": "C1_asr_confidence_ok",
      "desc": "ASR 置信度高且前两候选不冲突",
      "condition": "asr.confidence >= 0.88 AND (intent(nbest[0]) == intent(nbest[1]) OR (nbest[1].confidence <= 0.1))"
    },
    {
      "id": "C2_parser_agreement",
      "desc": "快慢模型主意图一致且关键槽位一致",
      "condition": "fast_parse.intent == slow_parse.intent AND slot_equal(fast_parse.slots, slow_parse.slots, keys=required_slots(max_conf_intent(fast_parse,slow_parse)))"
    },
    {
      "id": "C3_novelty_low",
      "desc": "非长尾/新颖意图（任一解析新颖度均较低）",
      "condition": "min(fast_parse.novelty, slow_parse.novelty) <= 0.25"
    },
    {
      "id": "C4_need_clarify",
      "desc": "存在歧义/缺槽/多参照，建议澄清",
      "condition": "missing_slots(max_conf_parse(fast_parse,slow_parse)).count > 0 OR conflict(nbest)"
    }
  ],
  "thresholds": {
    "route_fast": "A1 && A2 && A3 && !B1 && !B2 && !B3 && C1 && C2 && (C4==false)",
    "route_slow": "B1 || B2 || (!A2) || (!A3) || (!C1) || (C3==false)",
    "route_clarify": "C4 && !B1 && !B2"
  }
}

```

```json
{
  "route": "fast | slow | clarify",
  "violations": ["B2_disruption_risk"],
  "score_breakdown": {"A": 1.0, "B": 0.0, "C": 0.8},
  "evidence": [
    {"leaf": "A2_slots_complete", "proof": "fast_parse.slots.level=20"},
    {"leaf": "C1_asr_confidence_ok", "proof": "ASR=0.92, nbest2.delta=0.85"}
  ],
  "next_action": "clarify_prompt_if_any",
  "latency_note": "under_budget|over_budget"
}

```

