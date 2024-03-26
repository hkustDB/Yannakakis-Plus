create or replace view aggView190502475219604512 as select id as v3 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin5677131195616927308 as select movie_id as v14 from movie_keyword as mk, aggView190502475219604512 where mk.keyword_id=aggView190502475219604512.v3;
create or replace view aggView8858848989935760104 as select v14 from aggJoin5677131195616927308 group by v14;
create or replace view aggJoin4446728839598617910 as select id as v14, title as v15 from title as t, aggView8858848989935760104 where t.id=aggView8858848989935760104.v14 and production_year>1990;
create or replace view aggView7685075909226341095 as select v14, MIN(v15) as v27 from aggJoin4446728839598617910 group by v14;
create or replace view aggJoin3138903932514534692 as select info_type_id as v1, info as v9, v27 from movie_info_idx as mi_idx, aggView7685075909226341095 where mi_idx.movie_id=aggView7685075909226341095.v14 and info>'2.0';
create or replace view aggView6085548581244079233 as select id as v1 from info_type as it where info= 'rating';
create or replace view aggJoin5448969512144543838 as select v9, v27 from aggJoin3138903932514534692 join aggView6085548581244079233 using(v1);
select MIN(v9) as v26,MIN(v27) as v27 from aggJoin5448969512144543838;
