create or replace view aggView7039478796305750863 as select id as v23, title as v37 from title as t where production_year>2014;
create or replace view aggJoin3437164087391425584 as select movie_id as v23, keyword_id as v8, v37 from movie_keyword as mk, aggView7039478796305750863 where mk.movie_id=aggView7039478796305750863.v23;
create or replace view aggView3183698538026206639 as select id as v8, keyword as v35 from keyword as k where keyword= 'marvel-cinematic-universe';
create or replace view aggJoin5371122511728265839 as select v23, v37, v35 from aggJoin3437164087391425584 join aggView3183698538026206639 using(v8);
create or replace view aggView5353994229127779584 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin7558379052105106991 as select movie_id as v23, v36 from cast_info as ci, aggView5353994229127779584 where ci.person_id=aggView5353994229127779584.v14;
create or replace view aggView1703625663194097505 as select v23, MIN(v37) as v37, MIN(v35) as v35 from aggJoin5371122511728265839 group by v23;
create or replace view aggJoin3174037731631729377 as select v36 as v36, v37, v35 from aggJoin7558379052105106991 join aggView1703625663194097505 using(v23);
select MIN(v35) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin3174037731631729377;
