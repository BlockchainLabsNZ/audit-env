var StandardToken = artifacts.require("StandardToken");
var Ownable = artifacts.require("Ownable");


module.exports = function(deployer) {
	return deployer.then(function(){
		return deployer.deploy(Ownable);
    }).then(function(){
      return deployer.deploy(StandardToken);
    })
};