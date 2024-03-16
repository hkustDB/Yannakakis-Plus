create or replace view aggView7991658833200558170 as select id as v14, name as v36 from name as n where name LIKE '%Downey%Robert%';
create or replace view aggJoin2268111548267854712 as select movie_id as v23, v36 from cast_info as ci, aggView7991658833200558170 where ci.person_id=aggView7991658833200558170.v14;
create or replace view aggView6739878885775966936 as select id as v23, title as v37 from title as t where production_year>2010;
create or replace view aggJoin7101129166335436888 as select movie_id as v23, keyword_id as v8, v37 from movie_keyword as mk, aggView6739878885775966936 where mk.movie_id=aggView6739878885775966936.v23;
create or replace view aggView2425401288722684875 as select v23, MIN(v36) as v36 from aggJoin2268111548267854712 group by v23;
create or replace view aggJoin5692934668717180570 as select v8, v37 as v37, v36 from aggJoin7101129166335436888 join aggView2425401288722684875 using(v23);
create or replace view aggView6538192421792805390 as select v8, MIN(v37) as v37, MIN(v36) as v36 from aggJoin5692934668717180570 group by v8;
create or replace view aggJoin3442487500267988849 as select keyword as v9, v37, v36 from keyword as k, aggView6538192421792805390 where k.id=aggView6538192421792805390.v8 and keyword= 'marvel-cinematic-universe';
select MIN(v9) as v35,MIN(v36) as v36,MIN(v37) as v37 from aggJoin3442487500267988849;
