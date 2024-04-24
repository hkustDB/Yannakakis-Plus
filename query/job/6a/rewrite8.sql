create or replace view aggView4067134952399243563 as select id as v8, keyword as v35 from keyword as k where keyword= 'marvel-cinematic-universe';
create or replace view aggJoin6352440330482772444 as select movie_id as v23, v35 from movie_keyword as mk, aggView4067134952399243563 where mk.keyword_id=aggView4067134952399243563.v8;
create or replace view aggView6103080367306776325 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin4662594016082432502 as select movie_id as v23, v36 from cast_info as ci, aggView6103080367306776325 where ci.person_id=aggView6103080367306776325.v14;
create or replace view aggView7193881606858939214 as select v23, MIN(v35) as v35 from aggJoin6352440330482772444 group by v23,v35;
create or replace view aggJoin1931100597143562865 as select id as v23, title as v24, production_year as v27, v35 from title as t, aggView7193881606858939214 where t.id=aggView7193881606858939214.v23 and production_year>2010;
create or replace view aggView4751864126108943826 as select v23, MIN(v35) as v35, MIN(v24) as v37 from aggJoin1931100597143562865 group by v23,v35;
create or replace view aggJoin3451687246691689686 as select v36 as v36, v35, v37 from aggJoin4662594016082432502 join aggView4751864126108943826 using(v23);
select MIN(v35) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin3451687246691689686;
