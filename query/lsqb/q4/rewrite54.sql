create or replace view aggView9114191827816753853 as select ParentMessageId as v1, COUNT(*) as annot from Comment_replyOf_Message as Comment_replyOf_Message group by ParentMessageId;
create or replace view aggJoin7430753578789491075 as select MessageId as v1, annot from Person_likes_Message as Person_likes_Message, aggView9114191827816753853 where Person_likes_Message.MessageId=aggView9114191827816753853.v1;
create or replace view aggView7340661663839796244 as select MessageId as v1, COUNT(*) as annot from Message_hasTag_Tag as Message_hasTag_Tag group by MessageId;
create or replace view aggJoin7798161291634012760 as select MessageId as v1, annot from Message_hasCreator_Person as Message_hasCreator_Person, aggView7340661663839796244 where Message_hasCreator_Person.MessageId=aggView7340661663839796244.v1;
create or replace view aggView4832672020961937949 as select v1, SUM(annot) as annot from aggJoin7798161291634012760 group by v1;
create or replace view aggJoin7885271196516427910 as select aggJoin7430753578789491075.annot * aggView4832672020961937949.annot as annot from aggJoin7430753578789491075 join aggView4832672020961937949 using(v1);
select SUM(annot) as v9 from aggJoin7885271196516427910;
