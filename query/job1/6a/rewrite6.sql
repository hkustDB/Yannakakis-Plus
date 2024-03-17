create or replace view aggView2458374082575977193 as select id as v8, keyword as v35 from keyword as k where keyword= 'marvel-cinematic-universe';
create or replace view aggJoin7557203989967243087 as select movie_id as v23, v35 from movie_keyword as mk, aggView2458374082575977193 where mk.keyword_id=aggView2458374082575977193.v8;
create or replace view aggView1498209668182391069 as select id as v23, title as v37 from title as t where production_year>2010;
create or replace view aggJoin3462098375164793313 as select v23, v35, v37 from aggJoin7557203989967243087 join aggView1498209668182391069 using(v23);
create or replace view aggView4054312044285010495 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin697767596300192790 as select movie_id as v23, v36 from cast_info as ci, aggView4054312044285010495 where ci.person_id=aggView4054312044285010495.v14;
create or replace view aggView4514873185271628710 as select v23, MIN(v35) as v35, MIN(v37) as v37 from aggJoin3462098375164793313 group by v23;
create or replace view aggJoin1078363351106851485 as select v36 as v36, v35, v37 from aggJoin697767596300192790 join aggView4514873185271628710 using(v23);
select MIN(v35) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin1078363351106851485;
