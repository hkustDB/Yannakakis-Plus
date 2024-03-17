create or replace view aggView1657348054216025141 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin4380390699983024769 as select movie_id as v23, v36 from cast_info as ci, aggView1657348054216025141 where ci.person_id=aggView1657348054216025141.v14;
create or replace view aggView5144016906986392207 as select id as v8, keyword as v35 from keyword as k where keyword= 'marvel-cinematic-universe';
create or replace view aggJoin4582085015287267863 as select movie_id as v23, v35 from movie_keyword as mk, aggView5144016906986392207 where mk.keyword_id=aggView5144016906986392207.v8;
create or replace view aggView6013990068722931025 as select v23, MIN(v36) as v36 from aggJoin4380390699983024769 group by v23;
create or replace view aggJoin3730377725630296788 as select v23, v35 as v35, v36 from aggJoin4582085015287267863 join aggView6013990068722931025 using(v23);
create or replace view aggView8649875675035825740 as select v23, MIN(v35) as v35, MIN(v36) as v36 from aggJoin3730377725630296788 group by v23;
create or replace view aggJoin8195624339652880033 as select title as v24, v35, v36 from title as t, aggView8649875675035825740 where t.id=aggView8649875675035825740.v23 and production_year>2014;
select MIN(v35) as v35,MIN(v36) as v36,MIN(v24) as v37 from aggJoin8195624339652880033;
