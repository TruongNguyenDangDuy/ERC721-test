// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

contract ERC721 {

  mapping(address => uint256) internal _balances;
  mapping(uint256 => address) internal _owner;
  mapping(address => mapping(address => bool)) private _operatorApprovals; 
  mapping(uint256 => address) internal _tokenApprovals;
  // events
  event ApprovalForAll(address indexed _owner, address indexed _operator, bool _approved);
  event Approval(address indexed _owner, address indexed _approved, uint256 indexed _tokenId);
  event Transfer(address indexed _from, address indexed _to, uint256 indexed _tokenId);
  // return number nft of number
  function balanceOf(address owner) public view returns(uint256) {
    require(owner != address(0), 'This is zero address');
    return _balances[owner];
  }
 // return the address that owner of nft
  function ownerOf(uint256 tokenId) public view returns(address) {
    address owner =_owner[tokenId];
    require(owner != address(0), 'TokenId does not exist');
    return owner;  
  }

// enable or disable a third party ('operator') to manage nft
  function setApprovalForAll(address operator, bool approved) external {
    _operatorApprovals[msg.sender][operator] = approved;
    emit ApprovalForAll(msg.sender, operator, approved);
  }
// check an address is an operator for another address
  function isApprovedForAll(address owner, address operator) public view returns(bool) {
    return _operatorApprovals[owner][operator];
  }
  // update or approved an address for an nft
  function approve(address to, uint256 tokenId) public payable {
    address owner = ownerOf(tokenId);
    require(owner == msg.sender || isApprovedForAll(owner, msg.sender), 'msg.sender is not the owner or the approved operator'); // check the owner of nft of the operate permission
    _tokenApprovals[tokenId] = to;
    emit Approval(owner, to, tokenId);
  }
  // get an aproved address for an nft 
  function getApproved(uint256 tokenId) public view returns(address) {
    require(_owner[tokenId] != address(0), 'TokenId does not exist');
    return _tokenApprovals[tokenId];
  }

// transfer the ownership of the nft
  function transferFrom(address from, address to, uint256 tokenId) public payable {
    address owner = ownerOf(tokenId);
    require(
      msg.sender == owner ||
      getApproved(tokenId) == msg.sender ||
      isApprovedForAll(owner, msg.sender),'Msg.sender is not the owner or approved for transfer'
    );
    require(owner == from, 'This is not the owner address');
    require(to != address(0), 'This address is the zero address');
    require(_owner[tokenId] != address(0), 'TokenId does not exist');
    approve(address(0), tokenId);
    _balances[from] -= 1;
    _balances[to] += 1;
    _owner[tokenId] = to;
    emit Transfer(from, to, tokenId);
  } 
  // standard transferFrom method
    // checks if the receiver smart contract is capable of receiving NFT
    function safeTransferFrom(address from, address to, uint256 tokenId, bytes memory _data) public payable{
        transferFrom(from, to, tokenId);
        require(_checkOnERC721Received(), "Receiver not implemented");
    }
    // simple version to check for nft receivability of a smart contract
    function _checkOnERC721Received() private pure returns(bool){
        return true;
    }
    //
    function safeTransferFrom(address from, address to, uint256 tokenId) external payable{
        safeTransferFrom(from, to, tokenId, "");
    }
    // EIP165 proposal: query if a contract implements another interface
    function supportInterface(bytes4 interfaceId) public pure virtual returns(bool){
        return interfaceId == 0x80ac58cd;
    }
}