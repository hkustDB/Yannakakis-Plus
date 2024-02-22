create or replace view aggView5941081910722614839 as select MessageId as v1, COUNT(*) as annot from Message_hasTag_Tag as Message_hasTag_Tag group by MessageId;
create or replace view aggJoin3132270312517560273 as select MessageId as v1, annot from Person_likes_Message as Person_likes_Message, aggView5941081910722614839 where Person_likes_Message.MessageId=aggView5941081910722614839.v1;
create or replace view aggView5802964891861754238 as select v1, SUM(annot) as annot from aggJoin3132270312517560273 group by v1;
create or replace view aggJoin3795561151777567269 as select ParentMessageId as v1, annot from Comment_replyOf_Message as Comment_replyOf_Message, aggView5802964891861754238 where Comment_replyOf_Message.ParentMessageId=aggView5802964891861754238.v1;
create or replace view aggView597487399386558704 as select MessageId as v1, COUNT(*) as annot from Message_hasCreator_Person as Message_hasCreator_Person group by MessageId;
create or replace view aggJoin8844580223201764853 as select aggJoin3795561151777567269.annot * aggView597487399386558704.annot as annot from aggJoin3795561151777567269 join aggView597487399386558704 using(v1);
select SUM(annot) as v9 from aggJoin8844580223201764853;
