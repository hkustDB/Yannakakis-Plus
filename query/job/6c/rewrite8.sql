create or replace view aggView5493352132288686923 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin2515753510784502518 as select movie_id as v23, v36 from cast_info as ci, aggView5493352132288686923 where ci.person_id=aggView5493352132288686923.v14;
create or replace view aggView7782410248971853793 as select id as v23, title as v37 from title as t where production_year>2014;
create or replace view aggJoin4374726833455502607 as select movie_id as v23, keyword_id as v8, v37 from movie_keyword as mk, aggView7782410248971853793 where mk.movie_id=aggView7782410248971853793.v23;
create or replace view aggView3662144154932920474 as select id as v8, keyword as v35 from keyword as k where keyword= 'marvel-cinematic-universe';
create or replace view aggJoin6312609690367959321 as select v23, v37, v35 from aggJoin4374726833455502607 join aggView3662144154932920474 using(v8);
create or replace view aggView2434619964151826145 as select v23, MIN(v37) as v37, MIN(v35) as v35 from aggJoin6312609690367959321 group by v23,v37,v35;
create or replace view aggJoin750379489567689081 as select v36 as v36, v37, v35 from aggJoin2515753510784502518 join aggView2434619964151826145 using(v23);
select MIN(v35) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin750379489567689081;
