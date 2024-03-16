create or replace view aggView4703918016622395331 as select id as v23, title as v37 from title as t where production_year>2000;
create or replace view aggJoin2997979437771849140 as select movie_id as v23, keyword_id as v8, v37 from movie_keyword as mk, aggView4703918016622395331 where mk.movie_id=aggView4703918016622395331.v23;
create or replace view aggView5542267062069255779 as select id as v8, keyword as v35 from keyword as k where keyword= 'marvel-cinematic-universe';
create or replace view aggJoin7231593857228456485 as select v23, v37 from aggJoin2997979437771849140 join aggView5542267062069255779 using(v8);
create or replace view aggView7100096060828586770 as select v23, MIN(v37) as v37 from aggJoin7231593857228456485 group by v23;
create or replace view aggJoin5572497128549386726 as select person_id as v14, v37 from cast_info as ci, aggView7100096060828586770 where ci.movie_id=aggView7100096060828586770.v23;
create or replace view aggView5546620474463035791 as select v14, MIN(v37) as v37 from aggJoin5572497128549386726 group by v14;
create or replace view aggJoin939051470072158877 as select name as v15, v37 from name as n, aggView5546620474463035791 where n.id=aggView5546620474463035791.v14 and name LIKE '%Downey%Robert%';
select MIN(v35) as v35,MIN(v15) as v36,MIN(v37) as v37 from aggJoin939051470072158877;
