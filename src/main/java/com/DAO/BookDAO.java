
package com.DAO;

import java.util.List;

import com.entity.BookDtls;

public interface BookDAO {
	
    public boolean addBooks(BookDtls b);
    
    public List<BookDtls> getAllBooks();
    
    public BookDtls getBookById(int id);
    
    public boolean updateEditBooks(BookDtls b);
    
    public boolean deleteBooks(int id);
    
    
    
    public List<BookDtls> getNewBook();
    
    public List<BookDtls> getRecentBook();
    
    public List<BookDtls> getOldBook();
    
    
    public List<BookDtls> getAllRecentBooks();
    
    public List<BookDtls> getAllNewBooks();
    
    public List<BookDtls> getAllOldBooks();
    
    
    public List<BookDtls> mythologyBooks();
    public List<BookDtls> programmingBooks();
    public List<BookDtls> AnimeBooks();
    public List<BookDtls> storyBooks();
    public List<BookDtls> novelBooks();
    public List<BookDtls> scifiBooks();
    public List<BookDtls> BioBooks();
    
    
    
    
    public List<BookDtls> getBookByOld(String email,String cate);
    
    public boolean oldBookDelete(String email,String cate,int id);
    
    public List<BookDtls> getBookBySearch(String ch);
    
}
