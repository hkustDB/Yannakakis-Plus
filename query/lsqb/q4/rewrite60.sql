create or replace view aggView1261358313631383022 as select MessageId as v1, COUNT(*) as annot from Message_hasTag_Tag as Message_hasTag_Tag group by MessageId;
create or replace view aggJoin1983337279003698136 as select MessageId as v1, annot from Person_likes_Message as Person_likes_Message, aggView1261358313631383022 where Person_likes_Message.MessageId=aggView1261358313631383022.v1;
create or replace view aggView1764321571434394548 as select v1, SUM(annot) as annot from aggJoin1983337279003698136 group by v1;
create or replace view aggJoin686601998141883371 as select MessageId as v1, annot from Message_hasCreator_Person as Message_hasCreator_Person, aggView1764321571434394548 where Message_hasCreator_Person.MessageId=aggView1764321571434394548.v1;
create or replace view aggView3632073953152510815 as select ParentMessageId as v1, COUNT(*) as annot from Comment_replyOf_Message as Comment_replyOf_Message group by ParentMessageId;
create or replace view aggJoin2755256291179873838 as select aggJoin686601998141883371.annot * aggView3632073953152510815.annot as annot from aggJoin686601998141883371 join aggView3632073953152510815 using(v1);
select SUM(annot) as v9 from aggJoin2755256291179873838;
