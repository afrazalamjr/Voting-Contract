// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract voting{
    struct voter{
        string vname;
        bool voted;

    }
    struct candidate{
        string cname;
        uint256 votes;


    }
    address public owner;
    

    mapping(address => voter) public voterlist;
    mapping(address => candidate) public candidatelist;


    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can call this function");
        _;
    }


    event registration(address indexed voterId, string name);
    event candidatereg(address indexed candId,string name);
    event vote(address indexed candId,address indexed voterId);






    constructor(){
        owner=msg.sender;
}

    function registervoter(string memory _name) external  {
        require(voterlist[msg.sender].voted == false, "voter already registered");
        voterlist[msg.sender]=voter(_name,false);
        emit registration(msg.sender,_name);
        }

    function candidateregistration(address canid,string memory _name) external onlyOwner{
        require(candidatelist[canid].votes==0,"candidate already registered");
        candidatelist[canid]=candidate(_name,0);
        emit candidatereg(canid,_name);
 }

    function votingg(address canid) external {
        require(voterlist[msg.sender].voted==false,"already voted");
        require(candidatelist[canid].votes>0,"not here");
        voterlist[msg.sender].voted=true;
        candidatelist[canid].votes++;

         emit vote(msg.sender, canid);

    }

    function getvotecoun(address canid) external view returns (uint256) {
        return candidatelist[canid].votes;

    }



}
