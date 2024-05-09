create or replace view aggView8347291645601355417 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin1461402174942602946 as select movie_id as v12 from movie_keyword as mk, aggView8347291645601355417 where mk.keyword_id=aggView8347291645601355417.v1;
create or replace view aggView9175304800358911502 as select v12, COUNT(*) as annot from aggJoin1461402174942602946 group by v12;
create or replace view aggJoin6170810662727958853 as select movie_id as v12, info as v7, annot from movie_info as mi, aggView9175304800358911502 where mi.movie_id=aggView9175304800358911502.v12 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American');
create or replace view aggView5050993945799328258 as select v12, SUM(annot) as annot from aggJoin6170810662727958853 group by v12;
create or replace view aggJoin9093976242811366160 as select production_year as v16, annot from title as t, aggView5050993945799328258 where t.id=aggView5050993945799328258.v12 and production_year>1990;
select SUM(annot) as v24 from aggJoin9093976242811366160;
