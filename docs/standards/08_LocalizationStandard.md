# 08_LocalizationStandard

Version: 1.0.0  
Status: Stable

---

# 1. Purpose（目的）

本文档定义 MyPilatesStudio 的多语言知识管理与本地化标准。

本标准适用于：

- Movement Knowledge
- Anatomy Knowledge
- Cue Knowledge
- Teaching Knowledge
- Clinical Knowledge
- Lesson Knowledge
- AI Retrieval
- User-facing Content

目标：

- 支持多语言知识展示与检索
- 保持 Knowledge Entity 与语言分离
- 保持专业术语一致
- 保持 Source Knowledge 可追溯
- 支持 AI Translation
- 支持 Translation Version Control
- 支持未来增加新语言而无需修改核心 Knowledge Schema

核心原则：

**One Knowledge Graph, Multiple Localized Representations.**

---

# 2. Supported Languages（支持语言）

MyPilatesStudio V1.0 支持以下语言：

| Locale | Language |
|---|---|
| zh-CN | 简体中文 |
| en | English |
| es | Español |
| hi | हिन्दी |

未来可以扩展：

- zh-TW
- en-US
- en-GB
- es-ES
- es-MX
- ja
- ko
- fr
- de
- pt

增加新语言不得要求修改核心 Knowledge Entity Schema。

---

# 3. Core Localization Principle（核心本地化原则）

Knowledge 与 Language 必须分离。

MyPilatesStudio 采用：

**Knowledge First, Localization Second.**

即：

```text
Source Knowledge
        ↓
Canonical Entity
        ↓
Structured Relationships
        ↓
Localization Layer
   ┌────┼────┬────┐
 zh-CN  en   es   hi
 不得建立：

Chinese Knowledge Base
English Knowledge Base
Spanish Knowledge Base
Hindi Knowledge Base

必须建立：

One Canonical Knowledge Base
+
Multiple Localization Layers

所有语言共享同一套 Knowledge Entity 与 Knowledge Relationships。

4. Canonical Entity（标准知识实体）

每一个 Knowledge Entity 必须拥有唯一、稳定、语言无关的标识。

例如：

REF-ESS-001-V03
ANAT-MG-001
ANAT-MUS-001
ANAT-JNT-001
ANAT-ACT-001

Entity Code 不属于任何语言。

例如：

ANAT-MUS-001

在以下所有语言中：

zh-CN
en
es
hi

始终代表同一个 Anatomy Entity。

不得为不同语言创建不同 Entity ID。

5. Authoring Language（知识编辑语言）

MyPilatesStudio V1.0 默认 Knowledge Authoring Language：

zh-CN

当前 Markdown Knowledge Files 采用：

Chinese-first
+
Standard English Terminology

例如：

Chinese Name:
踝背屈肌群

English Name:
Ankle Dorsiflexors

这是 V1.0 的标准 Authoring Format。

当前已有 Movement、Anatomy 等 Markdown 文件不需要因为 Localization Architecture 重新编写。

6. Source Language（来源语言）

Source Language 与 Authoring Language 必须区分。

Source Language 表示原始知识来源所使用的语言。

例如：

Source Language:
zh-CN

表示原始资料为中文。

Authoring Language 表示当前 Knowledge File 使用的编辑语言。

例如：

Authoring Language:
zh-CN

二者不得视为同一概念。

未来 Source Language 可以包括：

zh-CN
en
es
hi
other

Source Language 应作为 Source Metadata 保存。

7. Name Types（名称类型）

系统必须区分：

Canonical Name
Official Name
Localized Name
7.1 Canonical Name

Canonical Name 用于稳定识别专业 Entity。

例如：

Canonical Name:
Tibialis Anterior

Canonical Name 不因用户界面语言变化而改变。

7.2 Official Name

Official Name 是 Methodology、机构或 Source 使用的正式名称。

例如：

Official Methodology Name:
Heels on Bar

Official Name 属于来源体系本身。

普通 Localization 不得覆盖 Official Name。

如果 Methodology 本身提供官方目标语言名称，应优先保存官方名称。

7.3 Localized Name

Localized Name 用于不同语言中的展示、搜索和用户交互。

例如：

zh-CN:
双踵抵在脚踏杆上

en:
Heels on Bar

es:
...

hi:
...

Localized Name 不改变 Canonical Entity。

8. Language-Independent Data（语言无关数据）

以下信息原则上只保存一次：

Entity ID
Entity Code
Movement Code
Variant Code
Muscle Code
Muscle Group Code
Joint Code
Joint Action Code
Equipment Code
Methodology Code
Program Code
Entity Type
Relationship Type
Source ID
Source Pages
Version
Status
Numeric Values
Boolean Values
Dates
Structured Enums
Relationship IDs

例如：

contraction_type:
eccentric

属于结构化值。

不得建立：

contraction_type_zh
contraction_type_en
contraction_type_es
contraction_type_hi
9. Localizable Data（可本地化数据）

以下内容通常属于 Localizable Content：

Name
Description
Definition
Purpose
Movement Instructions
Starting Position Description
Key Points
Anatomy Description
Functional Description
Teaching Cue
Teaching Explanation
Observation
Common Error Description
Correction
Clinical Explanation
Lesson Description
User-facing Notes

这些内容可以拥有多个语言版本。

Localizable Content 应与核心 Knowledge Entity 分离。

10. Structured Values Must Not Be Translated（结构化值不得翻译）

数据库中的标准 Enum、Code 和 Relationship 不通过自然语言翻译进行保存。

例如：

contraction_type:
eccentric

joint_action:
ANAT-ACT-001

relationship_type:
recruits

这些底层值在所有语言中保持一致。

Localization Layer 可以将其显示为不同语言。

例如：

eccentric

zh-CN:
离心收缩

en:
Eccentric

es:
...

hi:
...

但底层值始终保持：

eccentric

不得通过翻译后的自然语言文本反向推断核心结构化数据。

11. Translation Data Model（翻译数据模型）

数据库不得采用：

name_zh
name_en
name_es
name_hi

或：

description_zh
description_en
description_es
description_hi

这种字段扩展方式。

推荐使用：

Core Entity
    ↓
Translation Records

例如：

anatomy_entities

id
code
entity_type
...

对应：

anatomy_entity_translations

id
entity_id
locale
name
description
translation_status
source_version
...

关系：

ANAT-MG-001
    │
    ├── zh-CN
    ├── en
    ├── es
    └── hi

增加新语言只增加 Translation Record。

不得修改核心 Entity Schema。

12. Field-Level Localization（字段级本地化）

Localization Architecture 必须允许不同字段独立维护。

例如：

name
description
purpose
key_points

这些字段可能在不同时间发生变化。

未来系统应能够识别：

Name:
Approved

Description:
Approved

Key Points:
Outdated

V1.0 数据库可以先采用 Entity-level Translation Status。

但 Schema 设计不得阻止未来升级为 Field-level Translation Status。

13. Terminology Registry（术语注册表）

专业术语不得完全依赖自由 AI Translation。

MyPilatesStudio 应维护统一的：

Terminology Registry

适用于：

Anatomy
Pilates
Equipment
Joint Actions
Muscle Names
Muscle Groups
Clinical Terminology
Methodology-specific Terminology

例如：

Term ID:
TERM-ANKLE-DORSIFLEXION

Canonical:
Ankle Dorsiflexion

zh-CN:
踝背屈

en:
Ankle Dorsiflexion

es:
...

hi:
...

翻译专业内容时应遵循：

Terminology Registry
        ↓
Sentence Translation

而不是：

Sentence
        ↓
AI independently translates terminology
14. Terminology Priority（术语优先级）

专业术语翻译优先级：

Official Methodology Terminology
Approved Standard Anatomy Terminology
Approved MyPilates Terminology Registry
Existing Approved Translation
AI Translation

AI 不得覆盖已经 Approved 的专业术语。

如果存在官方 Methodology Translation，应优先使用官方术语。

15. Aliases（别名）

每一种语言可以拥有自己的 Search Aliases。

例如：

Entity:
ANAT-MUS-001

可以拥有：

zh-CN Aliases:

胫骨前肌
胫前肌

以及：

en Aliases:

Tibialis Anterior
Anterior Tibial Muscle

Aliases 用于：

Search
AI Retrieval
User Query Matching
Terminology Mapping

Alias 不改变 Canonical Entity。

16. Translation Workflow（翻译工作流）

推荐流程：

Source Material
        ↓
Knowledge Authoring
        ↓
Source Verification
        ↓
Canonical Knowledge Approved
        ↓
Terminology Resolution
        ↓
AI / Human Translation
        ↓
Terminology Validation
        ↓
Review
        ↓
Approved Translation

Source Knowledge 尚未稳定时，不应批量维护多个正式语言版本。

17. Translation Status（翻译状态）

Translation Status 使用以下标准值：

draft
translated
reviewed
approved
outdated
17.1 Draft

翻译尚未完成。

17.2 Translated

已经生成完整翻译，但尚未审核。

17.3 Reviewed

已经完成语言或专业术语检查。

17.4 Approved

允许用于正式产品展示。

17.5 Outdated

Canonical Knowledge 已发生变化。

该 Translation 需要重新验证、重新翻译或重新审核。

18. Translation Version Tracking（翻译版本追踪）

每一个 Translation 必须能够记录其对应的 Canonical Knowledge Version。

例如：

Entity:
ANAT-MG-001

Canonical Version:
1.2.0

Locale:
es

Translation Source Version:
1.1.0

Translation Status:
outdated

系统因此可以识别 Translation 是否落后于当前 Canonical Knowledge。

19. Translation Provenance（翻译溯源）

Translation 应记录其产生方式。

标准 Translation Method：

human
ai
ai_human_review
professional

必要时可以记录：

Translator:

Reviewer:

Translated At:

Reviewed At:

Translation Tool / Model:

Translation Version:

Translation Provenance 与 Knowledge Source Provenance 必须分开。

20. Translation Is Not a Knowledge Source（翻译不是知识来源）

翻译不会产生新的 Source Knowledge。

例如原始知识来源：

Knowledge Source:
STOTT Pilates Manual, P27

其英文、西班牙文或印地语 Translation 仍然对应：

Knowledge Source:
STOTT Pilates Manual, P27

不得把：

AI Translation

记录为该知识事实的 Source。

AI Translation 只属于：

Translation Provenance
21. Meaning Preservation（语义保持）

Translation 的职责是保持 Canonical Knowledge 的含义。

翻译不得：

增加原文不存在的知识
删除重要限定条件
改变 Movement Sequence
改变 Anatomy Relationship
改变 Contraction Type
改变 Joint Action
改变数量或重复次数
改变 Precaution
改变 Contraindication
将 Derived Knowledge 添加进 Source Knowledge
将解释性内容伪装成 Source Fact

原则：

Translation
=
Meaning Preservation

而不是：

Translation
=
Knowledge Generation
22. Source Knowledge vs Derived Knowledge（来源知识与派生知识）

Localization 不改变 Knowledge Type。

例如：

Source Knowledge

翻译后仍然属于：

Source Knowledge

而：

Derived Knowledge

翻译后仍然属于：

Derived Knowledge

不得通过翻译改变 Knowledge Classification。

23. Professional Content Review（专业内容审核）

不同类型的内容采用不同审核等级。

23.1 General Content

例如：

UI Labels
General Descriptions
Non-clinical User-facing Content

可以采用：

AI Translation
        ↓
Language Review
        ↓
Approved
23.2 Anatomy & Movement Content

建议采用：

AI Translation
        ↓
Terminology Review
        ↓
Knowledge Review
        ↓
Approved
23.3 Clinical Content

Clinical Content 应采用更高审核标准：

AI Translation
        ↓
Terminology Review
        ↓
Professional / Clinical Review
        ↓
Approved

未经相应审核的专业内容不得自动获得 Approved Status。

24. Methodology-Specific Content（体系专有内容）

STOTT Pilates 等 Methodology 的正式术语必须与普通 Localization 区分。

例如：

Official Name:
Heels on Bar

可以拥有：

Localized Display Name:
双踵抵在脚踏杆上

但 Localization 不得修改：

Official Name

如果 Methodology 本身提供官方目标语言版本，应优先使用官方名称，而不是 AI 自行翻译。

25. Multilingual Retrieval（多语言检索）

用户可以使用任意支持语言进行搜索。

例如：

胫骨前肌

Tibialis Anterior

Spanish Term

Hindi Term

系统首先解析到统一 Canonical Entity：

ANAT-MUS-001

然后通过统一 Knowledge Graph 查询相关知识。

推荐流程：

User Query
      ↓
Locale Detection
      ↓
Localized Name / Alias
      ↓
Canonical Entity
      ↓
Knowledge Graph
      ↓
Relevant Knowledge
      ↓
Localized Response

不得为每种语言建立独立 Retrieval Graph。

26. Cross-Language Retrieval（跨语言检索）

用户查询语言不限制底层 Knowledge Source 的语言。

例如：

Spanish Query
        ↓
Spanish Translation / Alias
        ↓
ANAT-MUS-001
        ↓
Chinese-authored Knowledge
        ↓
Canonical Relationships
        ↓
Spanish Approved Translation

因此：

Search Language

与：

Source Language

必须相互独立。

27. Localization Fallback（语言回退）

当 Requested Locale 没有 Approved Translation 时，系统必须使用明确的 Fallback Policy。

V1.0 推荐：

Requested Locale
        ↓
Approved Translation Available?
        │
       Yes
        ↓
Use Requested Locale

       No
        ↓
Approved English Available?
        │
       Yes
        ↓
Use English

       No
        ↓
Use zh-CN

即：

Requested Locale
→ en
→ zh-CN

不得将未经审核的实时 AI Translation 无标记地作为 Approved Translation 展示。

如果未来允许实时 AI Translation，必须明确标记其状态。

28. Locale Standard（Locale 标准）

系统内部使用标准 Locale Code。

V1.0：

zh-CN
en
es
hi

不得使用：

Chinese
English
Spanish
Indian

作为数据库 Locale Identifier。

其中：

hi

代表 Hindi（印地语）。

India 是多语言国家。

未来如果支持其他印度语言，应分别增加对应 Locale，而不是使用统一的 Indian Language Code。

29. File Naming（文件命名）

Knowledge Entity 文件名不得根据展示语言改变。

推荐：

ANAT-MG-001_ankle_dorsiflexors.md

不得为不同语言分别创建：

踝背屈肌群.md

ankle_dorsiflexors.md

spanish_name.md

hindi_name.md

Entity Code 是稳定标识。

Translation 属于 Entity 的 Localization Layer。

30. Markdown Authoring Policy（Markdown 编辑策略）

V1.0 Markdown 的主要职责：

Knowledge Authoring
Human Review
Source Verification
Git Version Control
Knowledge Maintenance

因此 Markdown 继续采用：

Chinese-first
+
English Professional Terminology

不要求同时维护：

zh-CN.md
en.md
es.md
hi.md

四套完整 Knowledge Files。

这样可以避免 Canonical Knowledge 修改后产生多个语言文件同步问题。

31. JSON Localization Policy（JSON 本地化规则）

Markdown 转换为结构化 JSON 时，应明确区分：

core

与：

translations

概念示例：

{
  "code": "ANAT-MG-001",
  "entity_type": "muscle_group",
  "translations": {
    "zh-CN": {
      "name": "踝背屈肌群"
    },
    "en": {
      "name": "Ankle Dorsiflexors"
    }
  }
}

尚未完成的语言不需要创建空字符串字段。

推荐：

{
  "translations": {
    "zh-CN": {
      "name": "踝背屈肌群"
    },
    "en": {
      "name": "Ankle Dorsiflexors"
    }
  }
}

而不是：

{
  "translations": {
    "zh-CN": {
      "name": "踝背屈肌群"
    },
    "en": {
      "name": "Ankle Dorsiflexors"
    },
    "es": {
      "name": ""
    },
    "hi": {
      "name": ""
    }
  }
}

Missing Translation Record 优于 Empty Translation Record。

32. Database Localization Policy（数据库本地化规则）

Supabase 应采用：

Core Entity Table
+
Translation Table

例如：

anatomy_entities

与：

anatomy_entity_translations

Movement、Cue、Teaching、Clinical 等 Knowledge Layer 遵循相同原则。

Translation Table 至少应能够表达：

entity_id
locale
localized_fields
translation_status
source_version
translation_method
review_metadata

具体 Database Schema 由 Database Standard 定义。

本文件只定义 Localization Architecture 与原则。

33. Relationship Localization（关系本地化）

Knowledge Graph Relationship 本身保持语言无关。

例如：

ANAT-MUS-001
        ↓
member_of
        ↓
ANAT-MG-001

该关系只建立一次。

不同语言只负责 Relationship Display Label。

例如底层：

member_of

UI 可以显示：

zh-CN:
属于

en:
Member of

es:
...

hi:
...

不得为不同语言重复创建 Knowledge Relationship。

34. Numbers, Units & Formatting（数字、单位与格式）

知识值与显示格式应尽可能分离。

例如：

repetitions_min:
10

repetitions_max:
12

优于只把核心数据保存成：

10–12 次

单位、数字格式和显示文本可以由 Localization / Presentation Layer 处理。

例如底层数据：

repetitions_min:
10

repetitions_max:
12

中文显示：

10–12 次

英文显示：

10–12 repetitions

如果 Source 本身只提供自然语言描述，应保留 Source 原始表达，不得为了结构化而改变其含义。

35. Translation Quality Principle（翻译质量原则）

专业知识翻译的优先目标：

Accuracy
Terminology Consistency
Meaning Preservation
Readability
Natural Language Style

专业准确性优先于语言修饰。

不得为了语言更加自然，而改变：

Pilates Meaning
Anatomy Meaning
Clinical Meaning
Movement Sequence
Source Meaning
36. Current Migration Policy（现有数据迁移）

当前已有 Movement Library 不需要因为本标准返工。

例如：

REF-ESS-001-V01
REF-ESS-001-V02
REF-ESS-001-V03
REF-ESS-001-V04
REF-ESS-001-V05

当前 Markdown 格式：

Chinese Name:
...

English Name:
...

继续允许作为 V1.0 Knowledge Authoring Format。

未来 Markdown → JSON / Supabase 时，再映射为：

Entity
    ↓
Translations
    ├── zh-CN
    ├── en
    ├── es
    └── hi

同样原则适用于当前 Anatomy Markdown。

37. V1.0 Implementation Strategy（V1.0 实施策略）

当前阶段：

Markdown
        ↓
Chinese-first Authoring
        ↓
Source Verification
        ↓
Knowledge Development

下一阶段：

Markdown
        ↓
Structured JSON
        ↓
Canonical Entity
+
Translation Model

数据库阶段：

JSON
        ↓
Supabase
        ↓
Core Tables
+
Translation Tables
+
Relationship Tables

应用阶段：

User Locale
        ↓
Localized Search
        ↓
Canonical Entity Retrieval
        ↓
Knowledge Graph
        ↓
Localized Response
38. Final Rules（最终规则）
MyPilatesStudio 使用一个统一 Knowledge Graph，而不是为不同语言建立独立知识库。
Knowledge Entity 与 Language 必须分离。
Entity Code 永远保持语言无关。
zh-CN 是 V1.0 默认 Knowledge Authoring Language。
Source Language 与 Authoring Language 必须区分。
Canonical Name、Official Name、Localized Name 必须区分。
Structured Values、Enums、Codes 和 Relationships 不进行语言复制。
Localizable Content 与核心 Entity Data 分离。
专业术语通过 Terminology Registry 统一管理。
AI Translation 不得覆盖 Approved Terminology。
Translation 不产生新的 Source Knowledge。
Translation 不得改变 Source Knowledge / Derived Knowledge Classification。
Translation 必须保持原始知识含义。
Translation 必须拥有独立 Status。
Translation 必须能够追踪对应的 Canonical Knowledge Version。
Translation Provenance 与 Knowledge Source Provenance 必须分离。
增加新语言不得要求修改核心 Knowledge Entity Schema。
不为每种语言建立独立 Knowledge Graph。
Markdown 负责 Knowledge Authoring、Review 和 Source Verification。
Markdown V1.0 继续采用 Chinese-first + English Professional Terminology。
当前已有 Movement / Anatomy Markdown 不需要因为 Localization Architecture 返工。
JSON 开始正式区分 Core Data 与 Translation Data。
Supabase 使用 Core Entity Table + Translation Table。
Knowledge Relationships 只建立一次，不按语言复制。
Missing Translation 使用明确 Fallback Policy。
Missing Translation Record 优于 Empty Translation Record。
Anatomy、Movement、Clinical 等专业内容采用比普通 UI Content 更高的 Translation Review 标准。
Methodology Official Terminology 不得被普通 AI Translation 覆盖。
多语言搜索最终必须解析到统一 Canonical Entity。
MyPilatesStudio 始终遵循：

One Canonical Knowledge System, Multiple Localized Representations.
