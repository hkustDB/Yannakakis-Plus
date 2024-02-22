create or replace view aggView5599470731735430182 as select MessageId as v1, COUNT(*) as annot from Person_likes_Message as Person_likes_Message group by MessageId;
create or replace view aggJoin1292316343476261364 as select MessageId as v1, annot from Message_hasCreator_Person as Message_hasCreator_Person, aggView5599470731735430182 where Message_hasCreator_Person.MessageId=aggView5599470731735430182.v1;
create or replace view aggView1559427868540268480 as select ParentMessageId as v1, COUNT(*) as annot from Comment_replyOf_Message as Comment_replyOf_Message group by ParentMessageId;
create or replace view aggJoin7497775100737472843 as select v1, aggJoin1292316343476261364.annot * aggView1559427868540268480.annot as annot from aggJoin1292316343476261364 join aggView1559427868540268480 using(v1);
create or replace view aggView4460461871205759330 as select MessageId as v1, COUNT(*) as annot from Message_hasTag_Tag as Message_hasTag_Tag group by MessageId;
create or replace view aggJoin1876108525381289988 as select aggJoin7497775100737472843.annot * aggView4460461871205759330.annot as annot from aggJoin7497775100737472843 join aggView4460461871205759330 using(v1);
select SUM(annot) as v9 from aggJoin1876108525381289988;
