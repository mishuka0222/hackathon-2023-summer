// SPDX-License-Identifier: MIT
// 
// TNT-721 Non-Fungible Token implementation based on the OpenZeppelin Lib
//
 
pragma solidity ^0.6.2;
 
pragma experimental ABIEncoderV2;
 
abstract contract Context {
    function _msgSender() internal view virtual returns (address payable) {
        return msg.sender;
    }
 
    function _msgData() internal view virtual returns (bytes memory) {
        this; // silence state mutability warning without generating bytecode - see https://github.com/ethereum/solidity/issues/2691
        return msg.data;
    }
}
 
library SafeMath {
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        require(c >= a, "SafeMath: addition overflow");
 
        return c;
    }
 
    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        return sub(a, b, "SafeMath: subtraction overflow");
    }
 
    function sub(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        require(b <= a, errorMessage);
        uint256 c = a - b;
 
        return c;
    }
 
    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        // Gas optimization: this is cheaper than requiring 'a' not being zero, but the
        // benefit is lost if 'b' is also tested.
        // See: https://github.com/OpenZeppelin/openzeppelin-contracts/pull/522
        if (a == 0) {
            return 0;
        }
 
        uint256 c = a * b;
        require(c / a == b, "SafeMath: multiplication overflow");
 
        return c;
    }
 
    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        return div(a, b, "SafeMath: division by zero");
    }
 
    function div(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        require(b > 0, errorMessage);
        uint256 c = a / b;
        // assert(a == b * c + a % b); // There is no case in which this doesn't hold
 
        return c;
    }
 
    function mod(uint256 a, uint256 b) internal pure returns (uint256) {
        return mod(a, b, "SafeMath: modulo by zero");
    }
 
    function mod(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        require(b != 0, errorMessage);
        return a % b;
    }
}
 
library Address {
 
    function isContract(address account) internal view returns (bool) {
        // This method relies on extcodesize, which returns 0 for contracts in
        // construction, since the code is only stored at the end of the
        // constructor execution.
 
        uint256 size;
        // solhint-disable-next-line no-inline-assembly
        assembly { size := extcodesize(account) }
        return size > 0;
    }
 
    function sendValue(address payable recipient, uint256 amount) internal {
        require(address(this).balance >= amount, "Address: insufficient balance");
 
        // solhint-disable-next-line avoid-low-level-calls, avoid-call-value
        (bool success, ) = recipient.call{ value: amount }("");
        require(success, "Address: unable to send value, recipient may have reverted");
    }
 
    function functionCall(address target, bytes memory data) internal returns (bytes memory) {
      return functionCall(target, data, "Address: low-level call failed");
    }
 
    function functionCall(address target, bytes memory data, string memory errorMessage) internal returns (bytes memory) {
        return _functionCallWithValue(target, data, 0, errorMessage);
    }
 
    function functionCallWithValue(address target, bytes memory data, uint256 value) internal returns (bytes memory) {
        return functionCallWithValue(target, data, value, "Address: low-level call with value failed");
    }
 
    function functionCallWithValue(address target, bytes memory data, uint256 value, string memory errorMessage) internal returns (bytes memory) {
        require(address(this).balance >= value, "Address: insufficient balance for call");
        return _functionCallWithValue(target, data, value, errorMessage);
    }
 
    function _functionCallWithValue(address target, bytes memory data, uint256 weiValue, string memory errorMessage) private returns (bytes memory) {
        require(isContract(target), "Address: call to non-contract");
 
        // solhint-disable-next-line avoid-low-level-calls
        (bool success, bytes memory returndata) = target.call{ value: weiValue }(data);
        if (success) {
            return returndata;
        } else {
            // Look for revert reason and bubble it up if present
            if (returndata.length > 0) {
                // The easiest way to bubble the revert reason is using memory via assembly
 
                // solhint-disable-next-line no-inline-assembly
                assembly {
                    let returndata_size := mload(returndata)
                    revert(add(32, returndata), returndata_size)
                }
            } else {
                revert(errorMessage);
            }
        }
    }
}
 
library EnumerableSet {
 
    struct Set {
        // Storage of set values
        bytes32[] _values;
 
        // Position of the value in the `values` array, plus 1 because index 0
        // means a value is not in the set.
        mapping (bytes32 => uint256) _indexes;
    }
 
    function _add(Set storage set, bytes32 value) private returns (bool) {
        if (!_contains(set, value)) {
            set._values.push(value);
            // The value is stored at length-1, but we add 1 to all indexes
            // and use 0 as a sentinel value
            set._indexes[value] = set._values.length;
            return true;
        } else {
            return false;
        }
    }
 
    function _remove(Set storage set, bytes32 value) private returns (bool) {
        // We read and store the value's index to prevent multiple reads from the same storage slot
        uint256 valueIndex = set._indexes[value];
 
        if (valueIndex != 0) { // Equivalent to contains(set, value)
            // To delete an element from the _values array in O(1), we swap the element to delete with the last one in
            // the array, and then remove the last element (sometimes called as 'swap and pop').
            // This modifies the order of the array, as noted in {at}.
 
            uint256 toDeleteIndex = valueIndex - 1;
            uint256 lastIndex = set._values.length - 1;
 
            // When the value to delete is the last one, the swap operation is unnecessary. However, since this occurs
            // so rarely, we still do the swap anyway to avoid the gas cost of adding an 'if' statement.
 
            bytes32 lastvalue = set._values[lastIndex];
 
            // Move the last value to the index where the value to delete is
            set._values[toDeleteIndex] = lastvalue;
            // Update the index for the moved value
            set._indexes[lastvalue] = toDeleteIndex + 1; // All indexes are 1-based
 
            // Delete the slot where the moved value was stored
            set._values.pop();
 
            // Delete the index for the deleted slot
            delete set._indexes[value];
 
            return true;
        } else {
            return false;
        }
    }
 
    function _contains(Set storage set, bytes32 value) private view returns (bool) {
        return set._indexes[value] != 0;
    }
 
    function _length(Set storage set) private view returns (uint256) {
        return set._values.length;
    }
 
    function _at(Set storage set, uint256 index) private view returns (bytes32) {
        require(set._values.length > index, "EnumerableSet: index out of bounds");
        return set._values[index];
    }
 
    struct AddressSet {
        Set _inner;
    }
 
    function add(AddressSet storage set, address value) internal returns (bool) {
        return _add(set._inner, bytes32(uint256(value)));
    }
 
    function remove(AddressSet storage set, address value) internal returns (bool) {
        return _remove(set._inner, bytes32(uint256(value)));
    }
 
    function contains(AddressSet storage set, address value) internal view returns (bool) {
        return _contains(set._inner, bytes32(uint256(value)));
    }
 
    function length(AddressSet storage set) internal view returns (uint256) {
        return _length(set._inner);
    }
 
    function at(AddressSet storage set, uint256 index) internal view returns (address) {
        return address(uint256(_at(set._inner, index)));
    }
 
    struct UintSet {
        Set _inner;
    }
 
    function add(UintSet storage set, uint256 value) internal returns (bool) {
        return _add(set._inner, bytes32(value));
    }
 
    function remove(UintSet storage set, uint256 value) internal returns (bool) {
        return _remove(set._inner, bytes32(value));
    }
 
    function contains(UintSet storage set, uint256 value) internal view returns (bool) {
        return _contains(set._inner, bytes32(value));
    }
 
    function length(UintSet storage set) internal view returns (uint256) {
        return _length(set._inner);
    }
 
    function at(UintSet storage set, uint256 index) internal view returns (uint256) {
        return uint256(_at(set._inner, index));
    }
}
 
library EnumerableMap {
 
    struct MapEntry {
        bytes32 _key;
        bytes32 _value;
    }
 
    struct Map {
        // Storage of map keys and values
        MapEntry[] _entries;
 
        // Position of the entry defined by a key in the `entries` array, plus 1
        // because index 0 means a key is not in the map.
        mapping (bytes32 => uint256) _indexes;
    }
 
    function _set(Map storage map, bytes32 key, bytes32 value) private returns (bool) {
        // We read and store the key's index to prevent multiple reads from the same storage slot
        uint256 keyIndex = map._indexes[key];
 
        if (keyIndex == 0) { // Equivalent to !contains(map, key)
            map._entries.push(MapEntry({ _key: key, _value: value }));
            // The entry is stored at length-1, but we add 1 to all indexes
            // and use 0 as a sentinel value
            map._indexes[key] = map._entries.length;
            return true;
        } else {
            map._entries[keyIndex - 1]._value = value;
            return false;
        }
    }
 
    function _remove(Map storage map, bytes32 key) private returns (bool) {
        // We read and store the key's index to prevent multiple reads from the same storage slot
        uint256 keyIndex = map._indexes[key];
 
        if (keyIndex != 0) { // Equivalent to contains(map, key)
            // To delete a key-value pair from the _entries array in O(1), we swap the entry to delete with the last one
            // in the array, and then remove the last entry (sometimes called as 'swap and pop').
            // This modifies the order of the array, as noted in {at}.
 
            uint256 toDeleteIndex = keyIndex - 1;
            uint256 lastIndex = map._entries.length - 1;
 
            // When the entry to delete is the last one, the swap operation is unnecessary. However, since this occurs
            // so rarely, we still do the swap anyway to avoid the gas cost of adding an 'if' statement.
 
            MapEntry storage lastEntry = map._entries[lastIndex];
 
            // Move the last entry to the index where the entry to delete is
            map._entries[toDeleteIndex] = lastEntry;
            // Update the index for the moved entry
            map._indexes[lastEntry._key] = toDeleteIndex + 1; // All indexes are 1-based
 
            // Delete the slot where the moved entry was stored
            map._entries.pop();
 
            // Delete the index for the deleted slot
            delete map._indexes[key];
 
            return true;
        } else {
            return false;
        }
    }
 
    function _contains(Map storage map, bytes32 key) private view returns (bool) {
        return map._indexes[key] != 0;
    }
 
    function _length(Map storage map) private view returns (uint256) {
        return map._entries.length;
    }
 
    function _at(Map storage map, uint256 index) private view returns (bytes32, bytes32) {
        require(map._entries.length > index, "EnumerableMap: index out of bounds");
 
        MapEntry storage entry = map._entries[index];
        return (entry._key, entry._value);
    }
 
    function _get(Map storage map, bytes32 key) private view returns (bytes32) {
        return _get(map, key, "EnumerableMap: nonexistent key");
    }
 
    function _get(Map storage map, bytes32 key, string memory errorMessage) private view returns (bytes32) {
        uint256 keyIndex = map._indexes[key];
        require(keyIndex != 0, errorMessage); // Equivalent to contains(map, key)
        return map._entries[keyIndex - 1]._value; // All indexes are 1-based
    }
 
    struct UintToAddressMap {
        Map _inner;
    }
 
    function set(UintToAddressMap storage map, uint256 key, address value) internal returns (bool) {
        return _set(map._inner, bytes32(key), bytes32(uint256(value)));
    }
 
    function remove(UintToAddressMap storage map, uint256 key) internal returns (bool) {
        return _remove(map._inner, bytes32(key));
    }
 
    function contains(UintToAddressMap storage map, uint256 key) internal view returns (bool) {
        return _contains(map._inner, bytes32(key));
    }
 
    function length(UintToAddressMap storage map) internal view returns (uint256) {
        return _length(map._inner);
    }
 
    function at(UintToAddressMap storage map, uint256 index) internal view returns (uint256, address) {
        (bytes32 key, bytes32 value) = _at(map._inner, index);
        return (uint256(key), address(uint256(value)));
    }
 
    function get(UintToAddressMap storage map, uint256 key) internal view returns (address) {
        return address(uint256(_get(map._inner, bytes32(key))));
    }
 
    function get(UintToAddressMap storage map, uint256 key, string memory errorMessage) internal view returns (address) {
        return address(uint256(_get(map._inner, bytes32(key), errorMessage)));
    }
}
 
library Strings {
 
    function toString(uint256 value) internal pure returns (string memory) {
        // Inspired by OraclizeAPI's implementation - MIT licence
        // https://github.com/oraclize/ethereum-api/blob/b42146b063c7d6ee1358846c198246239e9360e8/oraclizeAPI_0.4.25.sol
 
        if (value == 0) {
            return "0";
        }
        uint256 temp = value;
        uint256 digits;
        while (temp != 0) {
            digits++;
            temp /= 10;
        }
        bytes memory buffer = new bytes(digits);
        uint256 index = digits - 1;
        temp = value;
        while (temp != 0) {
            buffer[index--] = byte(uint8(48 + temp % 10));
            temp /= 10;
        }
        return string(buffer);
    }
}
 
interface ITNT165 {
    function supportsInterface(bytes4 interfaceId) external view returns (bool);
}
 
interface ITNT721 is ITNT165 {
    event Transfer(address indexed from, address indexed to, uint256 indexed tokenId);
    event Approval(address indexed owner, address indexed approved, uint256 indexed tokenId);
    event ApprovalForAll(address indexed owner, address indexed operator, bool approved);
    function balanceOf(address owner) external view returns (uint256 balance);
    function ownerOf(uint256 tokenId) external view returns (address owner);
    function safeTransferFrom(address from, address to, uint256 tokenId) external;
    function transferFrom(address from, address to, uint256 tokenId) external;
    function approve(address to, uint256 tokenId) external;
    function getApproved(uint256 tokenId) external view returns (address operator);
    function setApprovalForAll(address operator, bool _approved) external;
    function isApprovedForAll(address owner, address operator) external view returns (bool);
    function safeTransferFrom(address from, address to, uint256 tokenId, bytes calldata data) external;
}
 
interface ITNT721Metadata is ITNT721 {
    function name() external view returns (string memory);
    function symbol() external view returns (string memory);
    function tokenURI(uint256 tokenId) external view returns (string memory);
}
 
interface ITNT721Enumerable is ITNT721 {
    function totalSupply() external view returns (uint256);
    function tokenOfOwnerByIndex(address owner, uint256 index) external view returns (uint256 tokenId);
    function tokenByIndex(uint256 index) external view returns (uint256);
}
 
interface ITNT721Receiver {
    function onTNT721Received(address operator, address from, uint256 tokenId, bytes calldata data)
    external returns (bytes4);
}
 
contract TNT165 is ITNT165 {
 
    bytes4 private constant _INTERFACE_ID_TNT165 = 0x01ffc9a7;
 
    mapping(bytes4 => bool) private _supportedInterfaces;
 
    constructor () internal {
        _registerInterface(_INTERFACE_ID_TNT165);
    }
 
    function supportsInterface(bytes4 interfaceId) public view override returns (bool) {
        return _supportedInterfaces[interfaceId];
    }
 
    function _registerInterface(bytes4 interfaceId) internal virtual {
        require(interfaceId != 0xffffffff, "TNT165: invalid interface id");
        _supportedInterfaces[interfaceId] = true;
    }
}
 
// TNT stands for "Theta Network Token", TNT-721 is the non-fungible token
// standard on the Theta network, similar to the ERC-721 standard on Ethereum
contract TNT721 is Context, TNT165, ITNT721, ITNT721Metadata, ITNT721Enumerable {
    using SafeMath for uint256;
    using Address for address;
    using EnumerableSet for EnumerableSet.UintSet;
    using EnumerableMap for EnumerableMap.UintToAddressMap;
    using Strings for uint256;
    bytes4 private constant _TNT721_RECEIVED = 0x150b7a02;
    mapping (address => EnumerableSet.UintSet) private _holderTokens;
    EnumerableMap.UintToAddressMap private _tokenOwners;
    mapping (uint256 => address) private _tokenApprovals;
    mapping (address => mapping (address => bool)) private _operatorApprovals;
    string private _name;
    string private _symbol;
    mapping (uint256 => string) private _tokenURIs;
    string private _baseURI;
    bytes4 private constant _INTERFACE_ID_TNT721 = 0x80ac58cd;
    bytes4 private constant _INTERFACE_ID_TNT721_METADATA = 0x5b5e139f;
    bytes4 private constant _INTERFACE_ID_TNT721_ENUMERABLE = 0x780e9d63;
 
    constructor (string memory name, string memory symbol) public {
        _name = name;
        _symbol = symbol;
        _registerInterface(_INTERFACE_ID_TNT721);
        _registerInterface(_INTERFACE_ID_TNT721_METADATA);
        _registerInterface(_INTERFACE_ID_TNT721_ENUMERABLE);
    }
 
    function balanceOf(address owner) public view override returns (uint256) {
        require(owner != address(0), "TNT721: balance query for the zero address");
 
        return _holderTokens[owner].length();
    }
 
    function ownerOf(uint256 tokenId) public view override returns (address) {
        return _tokenOwners.get(tokenId, "TNT721: owner query for nonexistent token");
    }
 
    function name() public view override returns (string memory) {
        return _name;
    }
 
    function symbol() public view override returns (string memory) {
        return _symbol;
    }
 
    function tokenURI(uint256 tokenId) public view override returns (string memory) {
        require(_exists(tokenId), "TNT721Metadata: URI query for nonexistent token");
 
        string memory _tokenURI = _tokenURIs[tokenId];
 
        // If there is no base URI, return the token URI.
        if (bytes(_baseURI).length == 0) {
            return _tokenURI;
        }
        // If both are set, concatenate the baseURI and tokenURI (via abi.encodePacked).
        if (bytes(_tokenURI).length > 0) {
            return string(abi.encodePacked(_baseURI, _tokenURI));
        }
        // If there is a baseURI but no tokenURI, concatenate the tokenID to the baseURI.
        return string(abi.encodePacked(_baseURI, tokenId.toString()));
    }
 
    function baseURI() public view returns (string memory) {
        return _baseURI;
    }
 
    function tokenOfOwnerByIndex(address owner, uint256 index) public view override returns (uint256) {
        return _holderTokens[owner].at(index);
    }
 
    function totalSupply() public view override returns (uint256) {
        // _tokenOwners are indexed by tokenIds, so .length() returns the number of tokenIds
        return _tokenOwners.length();
    }
 
    function tokenByIndex(uint256 index) public view override returns (uint256) {
        (uint256 tokenId, ) = _tokenOwners.at(index);
        return tokenId;
    }
 
    function approve(address to, uint256 tokenId) public virtual override {
        address owner = ownerOf(tokenId);
        require(to != owner, "TNT721: approval to current owner");
 
        require(_msgSender() == owner || isApprovedForAll(owner, _msgSender()),
            "TNT721: approve caller is not owner nor approved for all"
        );
 
        _approve(to, tokenId);
    }
 
    function getApproved(uint256 tokenId) public view override returns (address) {
        require(_exists(tokenId), "TNT721: approved query for nonexistent token");
 
        return _tokenApprovals[tokenId];
    }
 
    function setApprovalForAll(address operator, bool approved) public virtual override {
        require(operator != _msgSender(), "TNT721: approve to caller");
 
        _operatorApprovals[_msgSender()][operator] = approved;
        emit ApprovalForAll(_msgSender(), operator, approved);
    }
 
    function isApprovedForAll(address owner, address operator) public view override returns (bool) {
        return _operatorApprovals[owner][operator];
    }
 
    function transferFrom(address from, address to, uint256 tokenId) public virtual override {
        //solhint-disable-next-line max-line-length
        require(_isApprovedOrOwner(_msgSender(), tokenId), "TNT721: transfer caller is not owner nor approved");
 
        _transfer(from, to, tokenId);
    }
 
    function safeTransferFrom(address from, address to, uint256 tokenId) public virtual override {
        safeTransferFrom(from, to, tokenId, "");
    }
 
    function safeTransferFrom(address from, address to, uint256 tokenId, bytes memory _data) public virtual override {
        require(_isApprovedOrOwner(_msgSender(), tokenId), "TNT721: transfer caller is not owner nor approved");
        _safeTransfer(from, to, tokenId, _data);
    }
 
    function _safeTransfer(address from, address to, uint256 tokenId, bytes memory _data) internal virtual {
        _transfer(from, to, tokenId);
        require(_checkOnTNT721Received(from, to, tokenId, _data), "TNT721: transfer to non TNT721Receiver implementer");
    }
 
    function _exists(uint256 tokenId) internal view returns (bool) {
        return _tokenOwners.contains(tokenId);
    }
 
    function _isApprovedOrOwner(address spender, uint256 tokenId) internal view returns (bool) {
        require(_exists(tokenId), "TNT721: operator query for nonexistent token");
        address owner = ownerOf(tokenId);
        return (spender == owner || getApproved(tokenId) == spender || isApprovedForAll(owner, spender));
    }
 
    function _safeMint(address to, uint256 tokenId) internal virtual {
        _safeMint(to, tokenId, "");
    }
 
    function _safeMint(address to, uint256 tokenId, bytes memory _data) internal virtual {
        _mint(to, tokenId);
        require(_checkOnTNT721Received(address(0), to, tokenId, _data), "TNT721: transfer to non TNT721Receiver implementer");
    }
 
    function _mint(address to, uint256 tokenId) internal virtual {
        require(to != address(0), "TNT721: mint to the zero address");
        require(!_exists(tokenId), "TNT721: token already minted");
 
        _beforeTokenTransfer(address(0), to, tokenId);
 
        _holderTokens[to].add(tokenId);
 
        _tokenOwners.set(tokenId, to);
 
        emit Transfer(address(0), to, tokenId);
    }
 
    function _burn(uint256 tokenId) internal virtual {
        address owner = ownerOf(tokenId);
 
        _beforeTokenTransfer(owner, address(0), tokenId);
 
        // Clear approvals
        _approve(address(0), tokenId);
 
        // Clear metadata (if any)
        if (bytes(_tokenURIs[tokenId]).length != 0) {
            delete _tokenURIs[tokenId];
        }
 
        _holderTokens[owner].remove(tokenId);
 
        _tokenOwners.remove(tokenId);
 
        emit Transfer(owner, address(0), tokenId);
    }
 
    function _transfer(address from, address to, uint256 tokenId) internal virtual {
        require(ownerOf(tokenId) == from, "TNT721: transfer of token that is not own");
        require(to != address(0), "TNT721: transfer to the zero address");
 
        _beforeTokenTransfer(from, to, tokenId);
 
        // Clear approvals from the previous owner
        _approve(address(0), tokenId);
 
        _holderTokens[from].remove(tokenId);
        _holderTokens[to].add(tokenId);
 
        _tokenOwners.set(tokenId, to);
 
        emit Transfer(from, to, tokenId);
    }
 
    function _setTokenURI(uint256 tokenId, string memory _tokenURI) internal virtual {
        require(_exists(tokenId), "TNT721Metadata: URI set of nonexistent token");
        _tokenURIs[tokenId] = _tokenURI;
    }
 
    function _setBaseURI(string memory baseURI_) internal virtual {
        _baseURI = baseURI_;
    }
 
    function _checkOnTNT721Received(address from, address to, uint256 tokenId, bytes memory _data)
        private returns (bool)
    {
        if (!to.isContract()) {
            return true;
        }
        bytes memory returndata = to.functionCall(abi.encodeWithSelector(
            ITNT721Receiver(to).onTNT721Received.selector,
            _msgSender(),
            from,
            tokenId,
            _data
        ), "TNT721: transfer to non TNT721Receiver implementer");
        bytes4 retval = abi.decode(returndata, (bytes4));
        return (retval == _TNT721_RECEIVED);
    }
 
    function _approve(address to, uint256 tokenId) private {
        _tokenApprovals[tokenId] = to;
        emit Approval(ownerOf(tokenId), to, tokenId);
    }
 
    function _beforeTokenTransfer(address from, address to, uint256 tokenId) internal virtual { }
}
 
contract CoolNFT is TNT721 {
    uint256 private _tokenIdCounter;
 
    mapping(uint256 => string) private _tokenURIs;
 
    constructor (string memory name, string memory symbol) public TNT721(name, symbol) {
        _tokenIdCounter = 0;
    }
 
    function mintNFT(string[] memory uris) public {
        for (uint256 i = 0; i < uris.length; i++) {
            uint256 newTokenId = _tokenIdCounter;
            _mint(msg.sender, newTokenId);
            _setTokenURI(newTokenId, uris[i]);
            _tokenIdCounter++;
        }
    }
 
    function setTokenURI(uint256 tokenId, string memory uri) public {
        require(_exists(tokenId), "Token does not exist");
        require(_isApprovedOrOwner(msg.sender, tokenId), "Not approved to modify token");
 
        _setTokenURI_(tokenId, uri);
    }
 
    function _setTokenURI_(uint256 tokenId, string memory uri) internal {
        _tokenURIs[tokenId] = uri;
    }
} 