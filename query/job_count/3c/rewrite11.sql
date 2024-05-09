create or replace view aggView3401343760679632695 as select movie_id as v12, COUNT(*) as annot from movie_info as mi where info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American') group by movie_id;
create or replace view aggJoin2217932165926675106 as select id as v12, production_year as v16, annot from title as t, aggView3401343760679632695 where t.id=aggView3401343760679632695.v12 and production_year>1990;
create or replace view aggView3289633383530666053 as select v12, SUM(annot) as annot from aggJoin2217932165926675106 group by v12;
create or replace view aggJoin8512315175343387122 as select keyword_id as v1, annot from movie_keyword as mk, aggView3289633383530666053 where mk.movie_id=aggView3289633383530666053.v12;
create or replace view aggView1423412972682266855 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin1964067767263154498 as select annot from aggJoin8512315175343387122 join aggView1423412972682266855 using(v1);
select SUM(annot) as v24 from aggJoin1964067767263154498;
