create or replace view aggView3224023057782437398 as select CommentId as v3, COUNT(*) as annot, TagId as v8 from Comment_hasTag_Tag as cht2 group by CommentId,TagId;
create or replace view aggJoin2619926474122071689 as select ParentMessageId as v1, v8, annot from Comment_replyOf_Message as Comment_replyOf_Message, aggView3224023057782437398 where Comment_replyOf_Message.CommentId=aggView3224023057782437398.v3;
create or replace view aggView6798124248633932693 as select v1, SUM(annot) as annot, v8 from aggJoin2619926474122071689 group by v1,v8;
create or replace view aggJoin3867128414820336311 as select TagId as v2, v8, annot from Message_hasTag_Tag as Message_hasTag_Tag, aggView6798124248633932693 where Message_hasTag_Tag.MessageId=aggView6798124248633932693.v1 and TagId<v8;
create or replace view aggView4861162616933587969 as select v2, SUM(annot) as annot from aggJoin3867128414820336311 group by v2;
create or replace view aggJoin5290146489873307442 as select TagId as v2, annot from Comment_hasTag_Tag as cht1, aggView4861162616933587969 where cht1.TagId=aggView4861162616933587969.v2;
select SUM(annot) as v9 from aggJoin5290146489873307442;
