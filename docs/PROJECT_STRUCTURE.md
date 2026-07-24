MyPilatesStudio 项目架构说明

Version: 1.0.0

Status: Draft

Owner: Xinlei Hu

Last Updated: 2026-07-24

项目定位：MyPilatesStudio 是一个面向普拉提教练和工作室的AI教学管理平台。

主要功能：
学员档案管理
课程记录
课程进度追踪
教练反馈记录
斯多特普拉提动作库（图文和短视频）
教学Cue库
根据疼痛、体态、孕产、训练目标筛选动作
AI自动生成课程（备课功能）
工作室和教练账户管理
未来的订阅与支付功能
——————————————————————————————————————————————————————
仓库结构：
mypilatesstudio/ 
│
├── app/ 
├── components/ 
├── features/ 
├── lib/ 
├── api/ 
├── prompts/ 
├── knowledge/ 
├── types/ 
├── config/ 
├── hooks/ 
├── services/ 
├── utils/ 
├── public/ 
├── styles/ 
├── tests/ 
├── scripts/ 
├── docs/ 
├── supabase/ 
├── .env.local
├── .env.example
├── .gitignore
├── README.md 
├── PROJECT_STRUCTURE.md 
├── package.json 
├── tsconfig.json 
└── next.config.js
-------------------------------------------------------------------
项目核心原则：
Knowledge is the Product. AI is the Interface.
整个项目最核心的资产不是 AI 模型，而是我多年积累的：
Movement Knowledge（动作知识）
Teaching Knowledge（教学知识）
Clinical Knowledge（临床推理）
Student Knowledge（学员数据）
Teaching Experience（教学经验）
AI 只是使用这些知识的推理引擎。

项目原则：
网站代码放 GitHub。
实际业务数据放 Supabase。
AI Prompt 应通过后端 API 或 Supabase Edge Function 调用。用户浏览器中不应出现完整 Prompt。
密钥不上传 GitHub。
每个教练和工作室只能访问自己的学员数据。
AI 结果必须经过验证，不能把 AI 的原始输出不经检查直接保存或展示。
知识库需要注明来源和版权状态。不要直接复制并商业化使用未获得授权的受版权保护教材。
