create or replace view aggView143183904638937687 as select id as v8, keyword as v35 from keyword as k where keyword IN ('superhero','sequel','second-part','marvel-comics','based-on-comic','tv-special','fight','violence');
create or replace view aggJoin8794722203552832305 as select movie_id as v23, v35 from movie_keyword as mk, aggView143183904638937687 where mk.keyword_id=aggView143183904638937687.v8;
create or replace view aggView656781584164677586 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin6089000227795688721 as select movie_id as v23, v36 from cast_info as ci, aggView656781584164677586 where ci.person_id=aggView656781584164677586.v14;
create or replace view aggView4204939197310639409 as select id as v23, title as v37 from title as t where production_year>2000;
create or replace view aggJoin4171742959999289399 as select v23, v36, v37 from aggJoin6089000227795688721 join aggView4204939197310639409 using(v23);
create or replace view aggView4275561693951971730 as select v23, MIN(v36) as v36, MIN(v37) as v37 from aggJoin4171742959999289399 group by v23;
create or replace view aggJoin1676667521767965475 as select v35 as v35, v36, v37 from aggJoin8794722203552832305 join aggView4275561693951971730 using(v23);
select MIN(v35) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin1676667521767965475;
