import type { ReactNode } from 'react'

export default function Home() {
  return (
    <section>
      <p className="intro">战略按主体分层，上层约束下层，下层具体化上层。</p>

      <LayerSection layer="社区战略" subject="量潮" question="社区为什么存在、向哪里去">
        <StrategyCard name="标准化">
          对重复发生的业务环节制定标准并依标准执行，降低非标准化业务的成本、提升其效率。
        </StrategyCard>
        <StrategyCard name="产教融合">
          教育用真实业务当教材，产业用学习过程当交付。
        </StrategyCard>
        <StrategyCard name="开打闭（Build in Public）">
          公开方法、标准、工具与业务过程，为中小企业实现知识与市场机会的平权。
        </StrategyCard>
      </LayerSection>

      <LayerSection layer="联盟战略" subject="量潮创新联盟" question="联盟成员如何协作共赢">
        <StrategyCard name="从自然人合作上升到法人合作">
          合作承诺以组织名义作出，交付以组织能力承接，信用以组织记录沉淀。
        </StrategyCard>
      </LayerSection>

      <LayerSection layer="公司战略" subject="量潮科技" question="公司做什么业务、如何配置资源">
        <StrategyCard name="从自然人到法人">
          由制度、标准、档案与系统承载经营能力，自然人作为参与者接入。
        </StrategyCard>
        <StrategyCard name="从项目制向产品制转型">
          将项目中沉淀的标准、工具与方法产品化，收入从按项目出售人力演进为按产品出售能力。
        </StrategyCard>
        <StrategyCard name="规模化增长">
          增长路线分为两个模式：产品转型与社区驱动增长。获客从个人关系转变为体系与社区的产出，形成不依赖特定个人的增长管道。
        </StrategyCard>
      </LayerSection>

      <LayerSection layer="业务战略" subject="量潮数据 / 量潮课堂 / 量潮云" question="该业务如何建立市场地位">
        <StrategyCard name="量潮数据">
          自我数字化改造即服务素材。
        </StrategyCard>
        <StrategyCard name="量潮课堂">
          阶梯化人才培养体系。
        </StrategyCard>
        <StrategyCard name="量潮云">
          社区的认知基础设施。
        </StrategyCard>
      </LayerSection>
    </section>
  )
}

function LayerSection({
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
    <section className="layer">
      <h2>{layer}</h2>
      <p className="layer-meta">
        主体：{subject} · 战略问题：{question}
      </p>
      <div className="cards">{children}</div>
    </section>
  )
}

function StrategyCard({ name, children }: { name: string; children: ReactNode }) {
  return (
    <article className="card">
      <h3>{name}</h3>
      {children}
    </article>
  )
}
