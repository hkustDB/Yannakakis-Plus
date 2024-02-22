create or replace view aggView3457443872932304584 as select ParentMessageId as v1, COUNT(*) as annot from Comment_replyOf_Message as Comment_replyOf_Message group by ParentMessageId;
create or replace view aggJoin1656141745188244909 as select MessageId as v1, annot from Person_likes_Message as Person_likes_Message, aggView3457443872932304584 where Person_likes_Message.MessageId=aggView3457443872932304584.v1;
create or replace view aggView8635689136048481085 as select MessageId as v1, COUNT(*) as annot from Message_hasTag_Tag as Message_hasTag_Tag group by MessageId;
create or replace view aggJoin6656759348531425941 as select v1, aggJoin1656141745188244909.annot * aggView8635689136048481085.annot as annot from aggJoin1656141745188244909 join aggView8635689136048481085 using(v1);
create or replace view aggView1092499750585240504 as select v1, SUM(annot) as annot from aggJoin6656759348531425941 group by v1;
create or replace view aggJoin2455039986963777546 as select annot from Message_hasCreator_Person as Message_hasCreator_Person, aggView1092499750585240504 where Message_hasCreator_Person.MessageId=aggView1092499750585240504.v1;
select SUM(annot) as v9 from aggJoin2455039986963777546;
