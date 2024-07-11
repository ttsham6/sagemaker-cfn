# sagamaker-cfn
SageMakerのCFnテンプレートです

## 前提条件
- 実行端末: Mac
- aws cliが使用できること

## 作成されるサービス
- VPC
- Subnet (AzA, AzC)
- IAM Role
- SageMaker
  - Lifecycle設定 ※ aws cliで作成
  - Domain
  - User profile
  - JupyterLab Space

## 構築手順

### 1. Lifecycle設定を作成
[create-lifecycle-config.sh](create-lifecycle-config.sh) を実行しlifecycle設定を作成します。


### 2. Cloudformationを実行
[SageMaker.yml](SageMaker.yml)を読み込みAWSサービスを作成します。

◼︎ パラメータ

| パラメータ名 | 説明 | デフォルト値 | 
| ---------- | ---- | ---- |
| EnvPrefix | AWSリソース名のプレフィックス | mlenv |
| VpcCidrBlock | SageMaker用VPCのCIDRブロック | 10.100.0.0/22 |
| SubnetAzACidrBlock | AzAサブネットのCIDRブロック | 10.100.0.0/28 |
| SubnetAzCCidrBlock | AzCサブネットのCIDRブロック | 10.100.0.16/28 |

◼︎ aws cliで作成する場合 <br>
```sh
$ aws cloudformation deploy \
  --stack-name ${YOUR_STACK_NAME} \
  --template-file ./SagaMaker.yml \
  --capabilities CAPABILITY_NAMED_IAM \
  --parameter-overrides EnvPrefix=${EnvPrefix} VpcCidrBlock=${VpcCidrBlock} \
  SubnetAzACidrBlock=${SubnetAzACidrBlock} SubnetAzCCidrBlock=${SubnetAzCCidrBlock} \
```

## 参考
- https://github.com/aws-samples/sagemaker-studio-apps-lifecycle-config-examples/tree/main/jupyterlab/auto-stop-idle
