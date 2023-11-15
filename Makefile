-include .env

build:
	forge build
deploy:
	forge script script/DeployAMMTest.s.sol  --rpc-url ${SEPOLIA_RPC_URL} --private-key ${PRIVATE_KEY} --broadcast --verify --etherscan-api-key ${ETHERSCAN_API_KEY} -vvvv

