// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract School {
    
    struct Student {
        uint256 score;
        string name;
        uint256 dateOfBrith;
        uint256 entryYear;
    }

    struct Teachers{
        string subject;
    }

    mapping(address => Student) public students;
    mapping (address=> Teachers) public teachers;
  
    address public Admin;


       constructor() {
        Admin=msg.sender;
    }


     modifier onlyAdmin() {
        require(msg.sender ==Admin, "Only admin can give permission");
        _;
    }

    modifier onlyTeacher(){
        require(bytes(teachers[msg.sender].subject).length > 0, "Only teachers can update scores");
        _;
    }


    function updateScore(address _studentAddr, uint256 newScore) onlyTeacher public {
    
        students[_studentAddr].score = newScore;
    }

    function addStudent(address _studentAddress,
     uint256 _initialScore,
     uint256 _dateOfBirth,
     string memory _name,
     uint256 _entryYear ) onlyAdmin public{
        students[_studentAddress] = Student(_initialScore,_name,_dateOfBirth,_entryYear );
    }

      function AddTeacher(address _newTeacher, string memory _subject) public onlyAdmin {
        
        teachers[_newTeacher]= Teachers(_subject);
    }


      function deleteTeacher(address _deleteTeacher) public onlyAdmin {  
        delete teachers[_deleteTeacher].subject;
    }
               
}