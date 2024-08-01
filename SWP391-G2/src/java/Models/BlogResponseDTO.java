/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Models;

import java.sql.Timestamp;

/**
 *
 * @author TNO
 */
public class BlogResponseDTO {
    private int id;
    private String title;
    private String brief;
    private String content;
    private String thumbnail;
    private Timestamp createdAt;
    private Timestamp updateAt;
    private int authorId;
    private boolean status;
    private String firstName;
    private String lastName;

    public BlogResponseDTO() {
    }

    public BlogResponseDTO(int id, String title, String brief, String content, String thumbnail, Timestamp createdAt, Timestamp updateAt, int authorId, boolean status, String firstName, String lastName) {
        this.id = id;
        this.title = title;
        this.brief = brief;
        this.content = content;
        this.thumbnail = thumbnail;
        this.createdAt = createdAt;
        this.updateAt = updateAt;
        this.authorId = authorId;
        this.status = status;
        this.firstName = firstName;
        this.lastName = lastName;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getBrief() {
        return brief;
    }

    public void setBrief(String brief) {
        this.brief = brief;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getThumbnail() {
        return thumbnail;
    }

    public void setThumbnail(String thumbnail) {
        this.thumbnail = thumbnail;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public Timestamp getUpdateAt() {
        return updateAt;
    }

    public void setUpdateAt(Timestamp updateAt) {
        this.updateAt = updateAt;
    }

    public int getAuthorId() {
        return authorId;
    }

    public void setAuthorId(int authorId) {
        this.authorId = authorId;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    @Override
    public String toString() {
        return "BlogResponseDTO{" + "id=" + id + ", title=" + title + ", brief=" + brief + ", content=" + content + ", thumbnail=" + thumbnail + ", createdAt=" + createdAt + ", updateAt=" + updateAt + ", authorId=" + authorId + ", status=" + status + ", firstName=" + firstName + ", lastName=" + lastName + '}';
    }

    
    
    
}
