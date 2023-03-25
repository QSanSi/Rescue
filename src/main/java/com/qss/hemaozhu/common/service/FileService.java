package com.qss.hemaozhu.common.service;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.util.UUID;

@Service
public class FileService {

    @Autowired(required = false)
    private HttpSession session;
    
    @Autowired
    private CommonService commonService;

    @Value("${file.location}")
    private String fileLocation;

    @Value("${file.server}")
    private String fileServer;
    
    /**
     * 上传文件到服务器
     *
     * @param uploadFile
     * @return
     */
    public String uploadpet(MultipartFile uploadFile) throws IOException {
        String fileName = uploadFile.getOriginalFilename();
        String suffix = fileName.substring(fileName.lastIndexOf("."));
        String uuid = UUID.randomUUID().toString().toUpperCase().replace("-", "");
        fileName = uuid + suffix;
        String foldername = commonService.getToday();
        String path = fileLocation + "/pet/" + foldername;
        String parent = session.getServletContext().getRealPath(path);
        File file = new File(parent, fileName);
        if (!file.exists()) {
            file.mkdirs();
        }
        uploadFile.transferTo(file);
        return path + "/" + fileName;
    }
    
    public String uploadcontract(MultipartFile uploadFile) throws IOException {
        String fileName = uploadFile.getOriginalFilename();
        String suffix = fileName.substring(fileName.lastIndexOf("."));
        String uuid = UUID.randomUUID().toString().toUpperCase().replace("-", "");
        fileName = uuid + suffix;
        String foldername = commonService.getToday();
        String path = fileLocation + "/contract/" + foldername;
        String parent = session.getServletContext().getRealPath(path);
        File file = new File(parent, fileName);
        if (!file.exists()) {
            file.mkdirs();
        }
        uploadFile.transferTo(file);
        return path + "/" + fileName;
    }
    
    public String uploadagreement(MultipartFile uploadFile) throws IOException {
        String fileName = uploadFile.getOriginalFilename();
        String suffix = fileName.substring(fileName.lastIndexOf("."));
        String uuid = UUID.randomUUID().toString().toUpperCase().replace("-", "");
        fileName = uuid + suffix;
        String foldername = commonService.getToday();
        String path = fileLocation + "/agreement/" + foldername;
        String parent = session.getServletContext().getRealPath(path);
        File file = new File(parent, fileName);
        if (!file.exists()) {
            file.mkdirs();
        }
        uploadFile.transferTo(file);
        return path + "/" + fileName;
    }
    
    public String uploadshop(MultipartFile uploadFile) throws IOException {
        String fileName = uploadFile.getOriginalFilename();
        String suffix = fileName.substring(fileName.lastIndexOf("."));
        String uuid = UUID.randomUUID().toString().toUpperCase().replace("-", "");
        fileName = uuid + suffix;
        String foldername = commonService.getToday();
        String path = fileLocation + "/shop/" + foldername;
        String parent = session.getServletContext().getRealPath(path);
        File file = new File(parent, fileName);
        if (!file.exists()) {
            file.mkdirs();
        }
        uploadFile.transferTo(file);
        return path + "/" + fileName;
    }
    
    public String uploadcityadopt(MultipartFile uploadFile) throws IOException {
        String fileName = uploadFile.getOriginalFilename();
        String suffix = fileName.substring(fileName.lastIndexOf("."));
        String uuid = UUID.randomUUID().toString().toUpperCase().replace("-", "");
        fileName = uuid + suffix;
        String foldername = commonService.getToday();
        String path = fileLocation + "/cityadopt/" + foldername;
        String parent = session.getServletContext().getRealPath(path);
        File file = new File(parent, fileName);
        if (!file.exists()) {
            file.mkdirs();
        }
        uploadFile.transferTo(file);
        return path + "/" + fileName;
    }
    
    public String uploadadopt(MultipartFile uploadFile) throws IOException {
        String fileName = uploadFile.getOriginalFilename();
        String suffix = fileName.substring(fileName.lastIndexOf("."));
        String uuid = UUID.randomUUID().toString().toUpperCase().replace("-", "");
        fileName = uuid + suffix;
        String foldername = commonService.getToday();
        String path = fileLocation + "/adopt/" + foldername;
        String parent = session.getServletContext().getRealPath(path);
        File file = new File(parent, fileName);
        if (!file.exists()) {
            file.mkdirs();
        }
        uploadFile.transferTo(file);
        return path + "/" + fileName;
    }
    
    public String uploadrescue(MultipartFile uploadFile) throws IOException {
        String fileName = uploadFile.getOriginalFilename();
        String suffix = fileName.substring(fileName.lastIndexOf("."));
        String uuid = UUID.randomUUID().toString().toUpperCase().replace("-", "");
        fileName = uuid + suffix;
        String foldername = commonService.getToday();
        String path = fileLocation + "/rescue/" + foldername;
        String parent = session.getServletContext().getRealPath(path);
        File file = new File(parent, fileName);
        if (!file.exists()) {
            file.mkdirs();
        }
        uploadFile.transferTo(file);
        return path + "/" + fileName;
    }
    
    public String uploadtips(MultipartFile uploadFile) throws IOException {
        String fileName = uploadFile.getOriginalFilename();
        String suffix = fileName.substring(fileName.lastIndexOf("."));
        String uuid = UUID.randomUUID().toString().toUpperCase().replace("-", "");
        fileName = uuid + suffix;
        String foldername = commonService.getToday();
        String path = fileLocation + "/tips/" + foldername;
        String parent = session.getServletContext().getRealPath(path);
        File file = new File(parent, fileName);
        if (!file.exists()) {
            file.mkdirs();
        }
        uploadFile.transferTo(file);
        return path + "/" + fileName;
    }
    
    /**
     * 通过文件绝对路径 删除单个文件
     * @param filePath
     */
    public boolean delFile(String fileName) {
    	String realpath = session.getServletContext().getRealPath(fileName);
        File delFile = new File(realpath);
        if(delFile.isFile() && delFile.exists()) {
            delFile.delete();
            return true;
        }else {
            return false;
        }
    }
    
}
