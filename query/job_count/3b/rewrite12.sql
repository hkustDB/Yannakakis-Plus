create or replace view aggView5955109571892491413 as select movie_id as v12, COUNT(*) as annot from movie_info as mi where info= 'Bulgaria' group by movie_id;
create or replace view aggJoin5940368998731915498 as select id as v12, production_year as v16, annot from title as t, aggView5955109571892491413 where t.id=aggView5955109571892491413.v12 and production_year>2010;
create or replace view aggView3579258118665734565 as select v12, SUM(annot) as annot from aggJoin5940368998731915498 group by v12;
create or replace view aggJoin4455012766138967065 as select keyword_id as v1, annot from movie_keyword as mk, aggView3579258118665734565 where mk.movie_id=aggView3579258118665734565.v12;
create or replace view aggView8793491012455206973 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin4135885677284842983 as select annot from aggJoin4455012766138967065 join aggView8793491012455206973 using(v1);
select SUM(annot) as v24 from aggJoin4135885677284842983;
