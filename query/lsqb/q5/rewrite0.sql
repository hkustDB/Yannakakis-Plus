create or replace view aggView5443875907633164974 as select CommentId as v3, COUNT(*) as annot, TagId as v6 from Comment_hasTag_Tag as cht group by CommentId,TagId;
create or replace view aggJoin987509928076069698 as select ParentMessageId as v1, v6, annot from Comment_replyOf_Message as Comment_replyOf_Message, aggView5443875907633164974 where Comment_replyOf_Message.CommentId=aggView5443875907633164974.v3;
create or replace view aggView7059406461889884561 as select v1, SUM(annot) as annot, v6 from aggJoin987509928076069698 group by v1,v6;
create or replace view aggJoin4433243253562232428 as select annot from Message_hasTag_Tag as Message_hasTag_Tag, aggView7059406461889884561 where Message_hasTag_Tag.MessageId=aggView7059406461889884561.v1 and TagId<v6;
select SUM(annot) as v7 from aggJoin4433243253562232428;
