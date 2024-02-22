create or replace view aggView3527831289631123152 as select MessageId as v1, COUNT(*) as annot from Message_hasCreator_Person as Message_hasCreator_Person group by MessageId;
create or replace view aggJoin5044872866392639043 as select ParentMessageId as v1, annot from Comment_replyOf_Message as Comment_replyOf_Message, aggView3527831289631123152 where Comment_replyOf_Message.ParentMessageId=aggView3527831289631123152.v1;
create or replace view aggView6706844006913692939 as select v1, SUM(annot) as annot from aggJoin5044872866392639043 group by v1;
create or replace view aggJoin7548948575513117706 as select MessageId as v1, annot from Message_hasTag_Tag as Message_hasTag_Tag, aggView6706844006913692939 where Message_hasTag_Tag.MessageId=aggView6706844006913692939.v1;
create or replace view aggView9065100730049688437 as select v1, SUM(annot) as annot from aggJoin7548948575513117706 group by v1;
create or replace view aggJoin2505399019402946827 as select annot from Person_likes_Message as Person_likes_Message, aggView9065100730049688437 where Person_likes_Message.MessageId=aggView9065100730049688437.v1;
select SUM(annot) as v9 from aggJoin2505399019402946827;
