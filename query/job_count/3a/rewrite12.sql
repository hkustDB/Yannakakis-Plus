create or replace view aggView2898382628137442758 as select movie_id as v12, COUNT(*) as annot from movie_info as mi where info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German') group by movie_id;
create or replace view aggJoin8514053166927859411 as select id as v12, production_year as v16, annot from title as t, aggView2898382628137442758 where t.id=aggView2898382628137442758.v12 and production_year>2005;
create or replace view aggView3103920367171263122 as select v12, SUM(annot) as annot from aggJoin8514053166927859411 group by v12;
create or replace view aggJoin5916682495807704319 as select keyword_id as v1, annot from movie_keyword as mk, aggView3103920367171263122 where mk.movie_id=aggView3103920367171263122.v12;
create or replace view aggView6902939700613349262 as select id as v1 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin4653231306316751823 as select annot from aggJoin5916682495807704319 join aggView6902939700613349262 using(v1);
select SUM(annot) as v24 from aggJoin4653231306316751823;
