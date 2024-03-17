create or replace view aggView3709832548754733619 as select id as v14, title as v27 from title as t where production_year>2010;
create or replace view aggJoin8600065009348750233 as select movie_id as v14, info_type_id as v1, info as v9, v27 from movie_info_idx as mi_idx, aggView3709832548754733619 where mi_idx.movie_id=aggView3709832548754733619.v14 and info>'9.0';
create or replace view aggView6307040082824232607 as select id as v3 from keyword as k where keyword LIKE '%sequel%';
create or replace view aggJoin988009276085082503 as select movie_id as v14 from movie_keyword as mk, aggView6307040082824232607 where mk.keyword_id=aggView6307040082824232607.v3;
create or replace view aggView6737105608201550866 as select v14 from aggJoin988009276085082503 group by v14;
create or replace view aggJoin6774661825550346419 as select v1, v9, v27 as v27 from aggJoin8600065009348750233 join aggView6737105608201550866 using(v14);
create or replace view aggView4610017941932657444 as select id as v1 from info_type as it where info= 'rating';
create or replace view aggJoin5815731202050984542 as select v9, v27 from aggJoin6774661825550346419 join aggView4610017941932657444 using(v1);
select MIN(v9) as v26,MIN(v27) as v27 from aggJoin5815731202050984542;
