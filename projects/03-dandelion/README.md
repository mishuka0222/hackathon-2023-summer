## 基本资料

项目名称：Dandelion(蒲公英)

项目立项日期 ：2023-05-20

## 项目整体简介
当前，区块链项目最好的发射方式当属空投，因其超低的参与门槛，超高的发射效率，但目前各个项目方在实施空投的过程中存在各种各样的问题，比如女巫攻击等等，dandelion（蒲公英）项目将基于Polkadot打造一个专业可复用的空投社区及发射台，通过社区结合区块链经济模型的模式，打造一套以社区经济模型驱动的可复用型空投发射平台，深度黏合项目方与用户，深度挖掘空投模式的潜力，使得各方利益最大化、成本最小化。 
At present, the best launch method of blockchain projects is airdrop, because of its ultra-low participation threshold, ultra-high launch efficiency, but at present, there are various problems in the process of implementing airdrops, such as witch attacks, etc., Dandelion project will be based on Polkadot to create a professional reusable airdrop community and launch pad, through the community combined with the blockchain economic model model, to create a set of community economic model driven reusable airdrop launch platform, Deeply bond the project party and users, deeply tap the potential of the airdrop model, maximize the benefits of all parties and minimize the cost.

- 项目背景/原由/要解决的问题 (如有其他附件，可放到 `docs` 目录内。英文提交)。
    空投是最优秀的项目发射模式，没有之一。得益于超低参与门槛的空投发射模式，可以使优秀的项目在短时间内积聚大量人气，这是一个优秀且经过市场验证的模式，但目前项目方在空投实施的过程中也存在很多的问题和痛点，其中危害最大的就是“女巫攻击” ，每一个空投的项目方都通过设置各种链上及社交平台交互等验证策略来减少“女巫攻击”的影响，但其效果并不理想。dandelion项目探索构想空投2.0的形态，通过将链上经济模型打造一个高粘性空投社区的方案解决这一问题，并可作为社区与项目方深度融合沟通的桥梁，彻底解决空投模式的痛点，并为波卡生态项目带来丰富多样的发射体验，降低波卡生态的参与门槛。
- 项目介绍
    dandelion项目，项目整体思路是深挖空投模式的潜力，探索空投2.0的形态，做一个黏合社区与各个项目方的专业化空投平台，建立一个随时准备就绪的黏性社区，节省项目方空投前的宣传以及时间成本，并通过社区经济模型杜绝女巫攻击及集中抛售对项目方的损失，使项目方获得真实有效的用户，也使真实的用户获益。大大节约项目推广的中间成本，使真正的好项目更易脱颖而出。也通过集中化的管理降低用户领取空投时遭受的欺诈风险。在项目就绪之后，计划转交社区治理，并完成去中心化的过程。
- 项目Demo
- 技术架构
    Substrate平行链 add Evm
- 项目 logo (如有)，这 logo 会印制在文宣，会场海报或贴子上。
    ![蒲公英](https://bafybeibtlnl6g3e7botlukk7vj3m2bp4ulezxqvmmycyjuuykbrtvcxr3a.ipfs.w3s.link/%E8%92%B2%E5%85%AC%E8%8B%B1.jpg "蒲公英logo")
    

- 项目的启始的commit，对于全新的项目可以是一个开源框架的clone，比如区块链clone自substrate-node-template, react
  框架等，请给出说明。对于成熟项目可以是一个branch，要求在2023年5月12号之后生成，说明有哪些功能是已经有了的

## 黑客松期间计划完成的事项
- 1.完成平行链基础功能开发（包括社区代币质押模块、自定义规则空投模块、用户账户画像模块等）
- 2.完成前端基础ui界面的设计（包括空投项目进度展示模块，用户空投领取进度模块，社区代币质押模块）

- 请团队在报名那一周 git clone 这个代码库并创建团队目录，在 readme 里列出黑客松期间内打算完成的代码功能点。并提交 PR 到本代码库。例子如下 (这只是一个 nft 项目的例子，请根据团队项目自身定义具体工作)：

**区块链端**
![后端](https://bafybeieqsf426u42wr4q5nw7nrssxwpjiubxgijvwb5xvh4kubnfho4vfq.ipfs.w3s.link/%E5%90%8E%E7%AB%AF.png "后端合约模块")

Dandelion 合约 && Substrate add Evm
1. 6月12日 社区质押合约和 币持有量同比例发放空投功能合约。
2. 6月14日 社区活跃度（签到token），每三日一个周期。
3. 6月17日 Substrate add Evm ,并能部署合约。
4. 6月23日 Substrate 修改成 web3用户钱包体系。
5. 6月30日 Substrate 修改成 POS 共识。


**客户端**

- web 端
    - [ ] 用户注册页面
    - [ ] NFT 产品创建流程
    - [ ] NFT 产品购买流程

- hybrid (react-native)
    - [ ] 用户注册页面
    - [ ] NFT 产品创建流程
    - [ ] NFT 产品购买流程


## 黑客松期间所完成的事项 (2023年7月4日上午11:59初审前提交)

- 2023年7月4日上午11:59前，在本栏列出黑客松期间最终完成的功能点。
- 把相关代码放在 `src` 目录里，并在本栏列出在黑客松期间完成的开发工作及代码结构。我们将对这些目录/档案作重点技术评审。
- Demo 视频，ppt等大文件不要提交。可以在readme中存放它们的链接地址

## 队员信息

| 姓名         | 角色         | GitHub 帐号  | 微信账号     |
| ----------- | ----------- | ----------- | ----------- |
| 聊心       | 区块链后端  | qqliaoxin   | wxliaoxin   |
| 心       | 区块链后端     |        |        |
| Zzz     | 区块链后端   |       |        |
| yan       | 前端        |             |        |
| 老张       | 前端        |             |         |
| h2na        | 产品        |             |         |
