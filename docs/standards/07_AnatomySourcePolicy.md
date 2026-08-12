# Anatomy Source Policy

Version:
1.0.0

Status:
Stable

---

# 1. Purpose（目的）

本文档定义 MyPilatesStudio Anatomy Knowledge 的知识来源、引用规则、证据等级及知识边界。

目标是确保 Anatomy Knowledge：

* 来源可靠
* 可以追溯
* 解剖术语统一
* 与 Pilates Movement Knowledge 明确分离
* 不将推理结果错误标记为 Source Knowledge
* 适合后续 AI Retrieval、Knowledge Graph 和数据库使用
* 尊重原始资料的版权及许可要求

---

# 2. Core Principle（核心原则）

Anatomy Knowledge 与 Movement Knowledge 必须保持独立的知识来源。

基本原则：

```text
Movement Knowledge
=
What does the Pilates source say?

Anatomy Knowledge
=
What does the anatomy source say?
```

例如：

STOTT Pilates 教材明确写：

```text
踝背屈肌群
```

Movement Library 应保存：

```text
Muscle Recruitment:
踝背屈肌群

Source:
STOTT Pilates Manual
```

不得直接扩展为具体肌肉。

具体肌肉组成应由 Anatomy Knowledge 独立定义。

---

# 3. Source Knowledge Only Principle（来源知识原则）

Anatomy Knowledge 中标记为 Source Knowledge 的内容必须能够由引用资料直接支持。

允许：

```text
Ankle Dorsiflexors
→ Tibialis Anterior
```

前提是 Anatomy Source 明确支持该关系。

不允许：

```text
STOTT:
Ankle Dorsiflexors

↓

自动推导：

Tibialis Anterior
```

并将该推导标记为 STOTT Source Knowledge。

---

# 4. Primary Anatomy Source（主要解剖学来源）

MyPilatesStudio Anatomy Knowledge V1.0 优先使用：

OpenStax
Anatomy & Physiology

作为主要基础解剖学来源。

主要用于建立：

* Muscle
* Muscle Group
* Origin
* Insertion
* Action
* Innervation
* Joint Relationship
* Body Region
* Anatomical Relationships

具体使用版本必须记录：

* Title
* Edition
* Chapter / Section
* Page or Location
* License
* Access Date（如适用）

不得仅记录：

```text
Source:
OpenStax
```

应尽可能保留足够的信息，使知识可以重新定位和验证。

---

# 5. Terminology Standard（术语标准）

标准解剖学名称优先参考国际标准解剖术语体系。

Preferred Terminology Standard:

FIPAT / Terminologia Anatomica

主要用于规范：

* Latin Name
* English Name
* Anatomical Entity Name
* Standard Anatomical Relationships

中文名称应采用通行的现代人体解剖学名称。

同义词、旧名称、常见教学名称不得替代 Canonical Name。

应作为：

```text
Aliases
```

单独保存。

---

# 6. Secondary Verification Sources（辅助核验来源）

必要时可以使用高质量 Anatomy Education Sources 对知识进行辅助核验。

例如：

* Kenhub
* TeachMeAnatomy

这些来源主要用于：

* Cross-check
* Terminology verification
* Clarification
* Detecting possible inconsistencies
* Locating concepts requiring further verification

除非许可明确允许，否则不得直接大量复制或系统性提取其内容建立 MyPilatesStudio 数据库。

Secondary Verification Source 不应自动覆盖 Primary Source。

如果不同来源存在差异，应保留差异并进一步核验。

---

# 7. Pilates Sources（普拉提来源）

Pilates 教材负责定义：

```text
Movement ↔ Anatomy
```

之间明确出现的关系。

例如 STOTT Pilates 教材写：

```text
利用双踝背屈肌群保持双脚姿势。
```

可以建立：

```text
REF-ESS-001-V03
    ↓ recruits
Ankle Dorsiflexors
```

Source:

STOTT Pilates Reformer Essential Manual

但不能因此直接建立：

```text
REF-ESS-001-V03
    ↓ recruits
Tibialis Anterior
```

除非 Pilates Source 本身明确提及 Tibialis Anterior。

---

# 8. Anatomy Expansion（解剖知识展开）

Movement Source 中出现的 Anatomy Concept 可以通过 Anatomy Knowledge 进一步展开。

例如：

```text
REF-ESS-001-V03
Heels on Bar

↓

recruits

Ankle Dorsiflexors
```

Anatomy Knowledge 可以进一步建立：

```text
Ankle Dorsiflexors

↓

includes

Tibialis Anterior
Extensor Hallucis Longus
Extensor Digitorum Longus
Fibularis Tertius
```

但两个关系必须拥有不同 Source。

例如：

```text
V03
→ Ankle Dorsiflexors

Source:
STOTT Pilates
```

而：

```text
Ankle Dorsiflexors
→ Tibialis Anterior

Source:
Anatomy Source
```

不得合并来源。

---

# 9. Direct Knowledge vs Derived Knowledge（直接知识与派生知识）

系统必须区分：

## Direct Knowledge

来源直接明确表达的信息。

例如：

```text
Source:
Anatomy Reference

Statement:
Tibialis Anterior contributes to ankle dorsiflexion.
```

可以作为 Source Knowledge。

---

## Derived Knowledge

通过多个已知关系推导得到的信息。

例如：

```text
STOTT:
V03 recruits ankle dorsiflexors

Anatomy:
Tibialis Anterior belongs to ankle dorsiflexors

Derived:

V03 may involve Tibialis Anterior
```

最后这一条属于：

```text
Derived Knowledge
```

而不是：

```text
STOTT Source Knowledge
```

---

# 10. AI Inference Policy（AI 推理规则）

AI 可以利用 Anatomy Knowledge Graph 进行关系推理。

但是必须区分：

```text
Source Fact
```

与：

```text
Derived Relationship
```

AI 不得：

* 将 Derived Knowledge 表述为教材原文
* 将 Anatomy Source 的知识归属于 Pilates Source
* 将 Pilates Source 未明确提到的具体肌肉标记为直接募集肌肉
* 自动生成没有可靠 Anatomy Source 支持的解剖事实

---

# 11. Source Priority（来源优先级）

当多个来源描述同一个 Anatomy Fact 时，优先级原则如下：

```text
1. Standard Anatomical Terminology
2. Primary Anatomy Source
3. Additional authoritative anatomy references
4. Secondary educational anatomy sources
5. Derived Knowledge
```

Pilates Source 不参与一般 Anatomy Fact 的来源优先级。

Pilates Source 只负责其自身明确描述的 Movement / Anatomy Relationship。

---

# 12. Source Granularity（来源粒度）

对于以下高价值 Anatomy Fields，应尽可能保存字段级 Source：

* Origin
* Insertion
* Innervation
* Action
* Muscle Group Membership
* Joint Relationship

例如：

```text
## Origin

Value:
...

Source:
...

---

## Insertion

Value:
...

Source:
...
```

不得因为整个 Anatomy Entity 有一个 Reference，就默认所有字段都由该 Reference 支持。

---

# 13. Conflicting Sources（来源冲突）

如果可靠来源之间存在差异：

不得自行删除其中一个观点。

不得由 AI 静默决定哪个一定正确。

应：

1. 保留主要来源描述。
2. 记录存在差异的字段。
3. 添加第二来源。
4. 标记为需要 Review。

例如：

```text
Status:
Needs Review
```

必要时可以记录：

```text
Source Conflict:
Yes
```

---

# 14. Copyright & Licensing（版权与许可）

所有 Anatomy Sources 在进入知识库之前必须确认其使用范围。

至少区分：

```text
Open License
Public Domain
Restricted Copyright
Verification Only
```

允许公开访问：

```text
Publicly Accessible
```

不等于：

```text
Free to Copy
```

不得因为网页可以访问，就自动复制、批量提取或重新发布其内容。

---

# 15. Open-License Sources（开放许可来源）

对于允许再利用的资料，应记录：

```text
Source:

Edition:

License:

Attribution:
```

如果许可要求 Attribution，应保留必要的来源信息。

如果许可包含：

```text
NC
NonCommercial
```

则在 MyPilatesStudio 可能商业化的情况下，不应默认作为可重新发布的商业数据源。

如果许可包含：

```text
SA
ShareAlike
```

必须在使用前评估其对衍生数据及产品分发方式的影响。

---

# 16. Restricted Sources（受限制来源）

受版权保护但允许阅读的资料可以用于：

* Research
* Verification
* Cross-checking
* Identifying concepts requiring further research

但不得未经授权：

* 大量复制原文
* 系统性提取内容
* 复制图片
* 建立内容镜像
* 将受限制内容作为可重新分发的数据集

---

# 17. Images & Illustrations（图片与插图）

Anatomy Text Data 与 Anatomy Images 应采用不同的版权策略。

不得因为文字资料允许引用，就默认其图片也可以进入产品。

Anatomy Images 必须单独确认：

```text
Image Source
Image License
Attribution Requirement
Commercial Use Permission
Modification Permission
```

未经明确许可的教材图片不得直接进入 MyPilatesStudio 产品资源库。

---

# 18. Knowledge Boundary（知识边界）

Anatomy Knowledge 负责：

```text
Muscle
Muscle Group
Joint
Joint Action
Anatomical Relationship
```

Movement Knowledge 负责：

```text
Movement
Starting Position
Movement Sequence
Breathing
Repetitions
Key Points
Muscle Recruitment stated by source
Alignment stated by source
```

Teaching Knowledge 负责：

```text
Cue
Observation
Common Error
Correction
Teaching Strategy
```

Clinical Knowledge 负责：

```text
Condition
Indication
Contraindication
Precaution
Clinical Reasoning
```

不同 Knowledge Layer 不应互相替代来源。

---

# 19. Knowledge Relationship Model（知识关系模型）

推荐的数据关系：

```text
Movement
    ↓ recruits
Muscle Group
    ↓ contains
Muscle
    ↓ performs
Joint Action
    ↓ occurs_at
Joint
```

同时允许：

```text
Movement
    ↓ directly_recruits
Muscle
```

但仅当 Movement Source 明确提及该具体肌肉时使用。

---

# 20. Pilates-Specific Anatomy Principle（普拉提解剖模型原则）

MyPilatesStudio 不以建立完整医学解剖百科为目标。

Anatomy Knowledge 的优先级由 Pilates 使用需求决定。

优先建立：

1. Movement Library 已经出现的 Anatomy Entity
2. Pilates 常用 Joint Actions
3. Pilates 常见 Muscle Groups
4. 与 Movement Analysis 高度相关的具体 Muscles
5. 与 Alignment 和 Stability 高度相关的 Anatomy Relationships

暂不优先建立与 Pilates 检索价值较低的大量医学细节。

---

# 21. Anatomy Expansion Workflow（解剖知识扩展流程）

推荐工作流：

```text
Pilates Manual
        ↓
Movement Entry
        ↓
Extract Anatomy Terms
        ↓
Check Existing Anatomy Entities
        ↓
Create Missing Anatomy Entity
        ↓
Verify with Anatomy Source
        ↓
Create Relationship
        ↓
Add Source
        ↓
Review
```

例如：

```text
V03 Heels on Bar
        ↓
踝背屈肌群
        ↓
Ankle Dorsiflexors
        ↓
Anatomy Source
        ↓
Specific Muscles
```

---

# 22. V1.0 Source Strategy（V1.0 来源策略）

MyPilatesStudio Anatomy Knowledge V1.0 采用：

```text
Pilates Movement Source
→ STOTT Pilates Manual

Primary Anatomy Source
→ Open-license anatomy reference selected for V1.0

Terminology Standard
→ FIPAT / Terminologia Anatomica

Secondary Verification
→ Authoritative anatomy education/reference sources
```

具体来源版本及 License 必须在实际录入 Anatomy Data 前确认。

---

# 23. Final Rule（最终规则）

任何 Anatomy Knowledge 在进入 MyPilatesStudio Knowledge Base 前，应能够回答：

```text
What is the fact?

Where did it come from?

Is it directly stated or derived?

What knowledge layer owns it?

Can this source legally be used for this purpose?
```

如果以上问题无法明确回答：

```text
Do not treat it as verified Anatomy Source Knowledge.
```
