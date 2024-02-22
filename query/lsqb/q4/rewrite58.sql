create or replace view aggView7480973000795080718 as select MessageId as v1, COUNT(*) as annot from Message_hasCreator_Person as Message_hasCreator_Person group by MessageId;
create or replace view aggJoin9090452442752772339 as select ParentMessageId as v1, annot from Comment_replyOf_Message as Comment_replyOf_Message, aggView7480973000795080718 where Comment_replyOf_Message.ParentMessageId=aggView7480973000795080718.v1;
create or replace view aggView5432051704246021956 as select v1, SUM(annot) as annot from aggJoin9090452442752772339 group by v1;
create or replace view aggJoin6217408722035322081 as select MessageId as v1, annot from Person_likes_Message as Person_likes_Message, aggView5432051704246021956 where Person_likes_Message.MessageId=aggView5432051704246021956.v1;
create or replace view aggView6924370117094709889 as select MessageId as v1, COUNT(*) as annot from Message_hasTag_Tag as Message_hasTag_Tag group by MessageId;
create or replace view aggJoin7157200072200396084 as select aggJoin6217408722035322081.annot * aggView6924370117094709889.annot as annot from aggJoin6217408722035322081 join aggView6924370117094709889 using(v1);
select SUM(annot) as v9 from aggJoin7157200072200396084;
