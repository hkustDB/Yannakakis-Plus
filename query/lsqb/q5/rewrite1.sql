create or replace view aggView7362690962331311873 as select CommentId as v3, COUNT(*) as annot, TagId as v6 from Comment_hasTag_Tag as cht group by CommentId,TagId;
create or replace view aggJoin5663474167358569980 as select ParentMessageId as v1, v6, annot from Comment_replyOf_Message as Comment_replyOf_Message, aggView7362690962331311873 where Comment_replyOf_Message.CommentId=aggView7362690962331311873.v3;
create or replace view aggView913447055218551950 as select v1, SUM(annot) as annot, v6 from aggJoin5663474167358569980 group by v1,v6;
create or replace view aggJoin4470329584814796370 as select TagId as v2, v6, annot from Message_hasTag_Tag as Message_hasTag_Tag, aggView913447055218551950 where Message_hasTag_Tag.MessageId=aggView913447055218551950.v1 and TagId<v6;
select SUM(annot) as v7 from aggJoin4470329584814796370;
