import type { ReactNode } from 'react'

export default function Home() {
  return (
    <section>
      <h2>战略分层</h2>
      <p>战略按主体分层，上层约束下层，下层具体化上层。</p>
      <div className="cards">
        <LayerCard
          layer="社区战略"
          subject="量潮"
          question="社区为什么存在、向哪里去"
        >
          <p>社区是以「量潮」为名的开放共同体，成员为量潮的全部利益相关方。社区战略由三项战略构成，并贯穿其他各战略层级：</p>
          <ul>
            <li><strong>标准化</strong>：对重复发生的业务环节制定标准并依标准执行，降低非标准化业务的成本、提升其效率。</li>
            <li><strong>产教融合</strong>：教育用真实业务当教材，产业用学习过程当交付。</li>
            <li><strong>开打闭（Build in Public）</strong>：公开方法、标准、工具与业务过程，为中小企业实现知识与市场机会的平权。</li>
          </ul>
        </LayerCard>

        <LayerCard
          layer="联盟战略"
          subject="量潮创新联盟"
          question="联盟成员如何协作共赢"
        >
          <p>核心主线：从自然人合作上升到法人合作。合作承诺以组织名义作出，交付以组织能力承接，信用以组织记录沉淀。</p>
        </LayerCard>

        <LayerCard
          layer="公司战略"
          subject="量潮科技"
          question="公司做什么业务、如何配置资源"
        >
          <p>基础主线：从自然人到法人——由制度、标准、档案与系统承载经营能力，自然人作为参与者接入。</p>
          <p>发展主线：从项目制向产品制转型；规模化获客。</p>
        </LayerCard>

        <LayerCard
          layer="业务战略"
          subject="量潮数据 / 量潮课堂 / 量潮云"
          question="该业务如何建立市场地位"
        >
          <ul>
            <li><strong>量潮数据</strong>：自我数字化改造即服务素材。</li>
            <li><strong>量潮课堂</strong>：阶梯化人才培养体系。</li>
            <li><strong>量潮云</strong>：社区的认知基础设施。</li>
          </ul>
        </LayerCard>
      </div>
    </section>
  )
}

function LayerCard({
  layer,
  subject,
  question,
  children,
}: {
  layer: string
  subject: string
  question: string
  children: ReactNode
}) {
  return (
    <article className="card">
      <h3>{layer}</h3>
      <p className="card-meta">
        主体：{subject} · 战略问题：{question}
      </p>
      {children}
    </article>
  )
}
