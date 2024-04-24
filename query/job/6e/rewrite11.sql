create or replace view aggView2708590973960136450 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin7949978466430145167 as select movie_id as v23, v36 from cast_info as ci, aggView2708590973960136450 where ci.person_id=aggView2708590973960136450.v14;
create or replace view aggView7784655199218767272 as select id as v8, keyword as v35 from keyword as k where keyword= 'marvel-cinematic-universe';
create or replace view aggJoin479353196189867565 as select movie_id as v23, v35 from movie_keyword as mk, aggView7784655199218767272 where mk.keyword_id=aggView7784655199218767272.v8;
create or replace view aggView6011769085136988207 as select id as v23, title as v37 from title as t where production_year>2000;
create or replace view aggJoin749130807606456467 as select v23, v36, v37 from aggJoin7949978466430145167 join aggView6011769085136988207 using(v23);
create or replace view aggView1334196507870366328 as select v23, MIN(v35) as v35 from aggJoin479353196189867565 group by v23,v35;
create or replace view aggJoin1663264001553027292 as select v36 as v36, v37 as v37, v35 from aggJoin749130807606456467 join aggView1334196507870366328 using(v23);
select MIN(v35) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin1663264001553027292;
