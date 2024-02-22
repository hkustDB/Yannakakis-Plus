create or replace view aggView4885128714402613338 as select MessageId as v1, COUNT(*) as annot from Person_likes_Message as Person_likes_Message group by MessageId;
create or replace view aggJoin7358925908896892512 as select MessageId as v1, annot from Message_hasTag_Tag as Message_hasTag_Tag, aggView4885128714402613338 where Message_hasTag_Tag.MessageId=aggView4885128714402613338.v1;
create or replace view aggView1375311076180656329 as select ParentMessageId as v1, COUNT(*) as annot from Comment_replyOf_Message as Comment_replyOf_Message group by ParentMessageId;
create or replace view aggJoin6679349063663734379 as select MessageId as v1, annot from Message_hasCreator_Person as Message_hasCreator_Person, aggView1375311076180656329 where Message_hasCreator_Person.MessageId=aggView1375311076180656329.v1;
create or replace view aggView2946482791250067266 as select v1, SUM(annot) as annot from aggJoin6679349063663734379 group by v1;
create or replace view aggJoin9217689904622809532 as select aggJoin7358925908896892512.annot * aggView2946482791250067266.annot as annot from aggJoin7358925908896892512 join aggView2946482791250067266 using(v1);
select SUM(annot) as v9 from aggJoin9217689904622809532;
