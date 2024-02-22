create or replace view aggView4689928526295648768 as select CommentId as v3, COUNT(*) as annot, TagId as v8 from Comment_hasTag_Tag as cht2 group by CommentId,TagId;
create or replace view aggJoin918727650503960768 as select ParentMessageId as v1, v8, annot from Comment_replyOf_Message as Comment_replyOf_Message, aggView4689928526295648768 where Comment_replyOf_Message.CommentId=aggView4689928526295648768.v3;
create or replace view aggView6365622366245887929 as select v1, SUM(annot) as annot, v8 from aggJoin918727650503960768 group by v1,v8;
create or replace view aggJoin1421266800296292933 as select TagId as v2, annot from Message_hasTag_Tag as Message_hasTag_Tag, aggView6365622366245887929 where Message_hasTag_Tag.MessageId=aggView6365622366245887929.v1 and TagId<v8;
create or replace view aggView4149257932324569797 as select v2, SUM(annot) as annot from aggJoin1421266800296292933 group by v2;
create or replace view aggJoin9078950573125332319 as select annot from Comment_hasTag_Tag as cht1, aggView4149257932324569797 where cht1.TagId=aggView4149257932324569797.v2;
select SUM(annot) as v9 from aggJoin9078950573125332319;
