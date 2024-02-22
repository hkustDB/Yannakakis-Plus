create or replace view aggView4636586816008275468 as select ParentMessageId as v1, COUNT(*) as annot from Comment_replyOf_Message as Comment_replyOf_Message group by ParentMessageId;
create or replace view aggJoin637536949052324524 as select MessageId as v1, annot from Person_likes_Message as Person_likes_Message, aggView4636586816008275468 where Person_likes_Message.MessageId=aggView4636586816008275468.v1;
create or replace view aggView5766688238499104878 as select MessageId as v1, COUNT(*) as annot from Message_hasCreator_Person as Message_hasCreator_Person group by MessageId;
create or replace view aggJoin5460590824564954380 as select v1, aggJoin637536949052324524.annot * aggView5766688238499104878.annot as annot from aggJoin637536949052324524 join aggView5766688238499104878 using(v1);
create or replace view aggView7082184770041183965 as select MessageId as v1, COUNT(*) as annot from Message_hasTag_Tag as Message_hasTag_Tag group by MessageId;
create or replace view aggJoin5135338058887705644 as select aggJoin5460590824564954380.annot * aggView7082184770041183965.annot as annot from aggJoin5460590824564954380 join aggView7082184770041183965 using(v1);
select SUM(annot) as v9 from aggJoin5135338058887705644;
