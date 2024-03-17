create or replace view aggView3658822539149417103 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin32632627259025181 as select movie_id as v23, v36 from cast_info as ci, aggView3658822539149417103 where ci.person_id=aggView3658822539149417103.v14;
create or replace view aggView6783979456366929565 as select id as v8, keyword as v35 from keyword as k where keyword IN ('superhero','sequel','second-part','marvel-comics','based-on-comic','tv-special','fight','violence');
create or replace view aggJoin4112395076900791823 as select movie_id as v23, v35 from movie_keyword as mk, aggView6783979456366929565 where mk.keyword_id=aggView6783979456366929565.v8;
create or replace view aggView9010316571584703301 as select v23, MIN(v36) as v36 from aggJoin32632627259025181 group by v23;
create or replace view aggJoin4469664405330790214 as select id as v23, title as v24, v36 from title as t, aggView9010316571584703301 where t.id=aggView9010316571584703301.v23 and production_year>2000;
create or replace view aggView5339098868637875570 as select v23, MIN(v35) as v35 from aggJoin4112395076900791823 group by v23;
create or replace view aggJoin6625437002769881365 as select v24, v36 as v36, v35 from aggJoin4469664405330790214 join aggView5339098868637875570 using(v23);
select MIN(v35) as v35,MIN(v36) as v36,MIN(v24) as v37 from aggJoin6625437002769881365;
