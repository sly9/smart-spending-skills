# smart-spending-skills

Claude skills for spending smarter. Each skill stacks **your own** credit cards, memberships, cashback portals and live deals, verifies every discount live, and keeps warranty and return protection in the picture. The skills contain no personal data. Each person points them at their own profile.

一组帮你「花钱更聪明」的 Claude skill：结合你自己的信用卡、会员、返利网站和实时 deal，每个折扣都在线核实，同时兼顾延保和退货保障。skill 里不含任何个人信息，每个人用自己的个人档案。

| Skill | 做什么 / What it does | Status |
|---|---|---|
| [smart-shopping-optimizer](skills/smart-shopping-optimizer/SKILL.md) | 大件零售和电子产品：去哪买、什么时候买、刷哪张卡、到手价多少 / Big-ticket retail and electronics: where, when, which card, verified net cost | ✅ |
| flight-optimizer | 机票：现金还是积分、转点、刷哪张卡 / Flights: cash vs. points, transfers, card choice | 🚧 planned |
| hotel-optimizer | 酒店：现金还是积分、会籍、FHR/THC、刷哪张卡 / Hotels: cash vs. points, elite status, premium-card programs | 🚧 planned |

## 安装 / Install

### A. Claude 账号（推荐，所有设备都能用）
1. 到 [Releases → latest](../../releases/latest) 下载 skill 的 zip（比如 `smart-shopping-optimizer.zip`），也可以在本地运行 `bash scripts/package.sh` 生成。
2. 在 claude.ai 里打开 **Customize → Skills**（有的版本在 **Settings → Capabilities → Skills**），上传这个 zip。
3. 上传之后，网页版、桌面版、手机版的 Claude 都能用，桌面版 Claude Code 也会自动同步过去。

**A. Your Claude account (recommended, works on every device).** Download the zip from the latest release, or build it with `bash scripts/package.sh`. Upload it in claude.ai under **Customize → Skills**. It then works in Claude on web, desktop and mobile, and syncs to Claude Code in the desktop app.

### B. Claude Code 插件 / Claude Code plugin
```
/plugin marketplace add sly9/smart-spending-skills
/plugin install smart-spending@smart-spending-skills
```

### C. 手动 / Manual
把 `skills/<name>/` 复制到 `~/.claude/skills/<name>/`。
Copy `skills/<name>/` to `~/.claude/skills/<name>/`.

## 提供你的个人档案 / Give it your profile

skill 会按这个顺序找你的信息：
1. 你的 CLAUDE.md、记忆或 Claude 账号偏好里指明的位置（私人 repo、文件或文档）
2. 对话里附上的档案
3. 都没有的话，按 [profile template](skills/smart-shopping-optimizer/references/profile-template.md) 问你最基本的信息

最省事的做法：按模板填一份，存到你自己的地方，然后在 CLAUDE.md（或者 claude.ai → Settings → Profile 的偏好设置）里加一句：

The skill looks for your profile in this order:
1. A location named in your CLAUDE.md, memory or Claude account preferences (a private repo, file or doc).
2. A profile attached in the conversation.
3. Otherwise, it asks you the basics from the [profile template](skills/smart-shopping-optimizer/references/profile-template.md).

The easiest setup is to fill in the template, keep it somewhere of yours, and add one line to your CLAUDE.md or claude.ai preferences:

> 我的信用卡、会员和消费规则在 `<repo / 文件 / 文档>`，做购物或刷卡决定前先去读。
> My cards, memberships and spending rules are in `<repo / file / doc>`. Read them before any shopping or card decision.

**不要把完整卡号、CVV、密码放进档案。** 卡名加尾号 4 位就够了。
**Never put full card numbers, CVVs or passwords in the profile.** Card names and the last 4 digits are enough.

## 原则 / Principles
- 只算今天在线核实过的折扣，论坛上的 DP 单独标注，不算进保底到手价。
  Count only discounts verified live today. Forum data points are tagged and left out of the guaranteed net cost.
- 大件优先正规商家和信用卡保障，不为一点折扣冒险。
  On big purchases, put authorized sellers and card protections ahead of small savings.
- 不推荐复杂的礼品卡玩法。
  No complicated gift-card schemes.
- Claude 只帮你算和准备，最后下单、付款由你自己来。
  Claude researches and prepares; you place the order and pay.

## License
MIT. Not financial advice. Card terms and deals change, so always verify before you buy.
MIT 许可。这不是理财建议。信用卡条款和 deal 经常变，买之前一定要再核实。
