create or replace view aggView5443875907633164974 as select CommentId as v3, TagId as v6 from Comment_hasTag_Tag as cht;
create or replace view aggJoin987509928076069698 as select ParentMessageId as v1, v6 from Comment_replyOf_Message as Comment_replyOf_Message, aggView5443875907633164974 where Comment_replyOf_Message.CommentId=aggView5443875907633164974.v3;
create or replace view aggView7059406461889884561 as select v1, v6 from aggJoin987509928076069698;
select count(*) from Message_hasTag_Tag as Message_hasTag_Tag, aggView7059406461889884561 where Message_hasTag_Tag.MessageId=aggView7059406461889884561.v1 and TagId<v6;
