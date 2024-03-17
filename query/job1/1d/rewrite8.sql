create or replace view aggView3052754631454827798 as select id as v15, title as v28, production_year as v29 from title as t where production_year>2000;
create or replace view aggJoin793553870736949522 as select movie_id as v15, info_type_id as v3, v28, v29 from movie_info_idx as mi_idx, aggView3052754631454827798 where mi_idx.movie_id=aggView3052754631454827798.v15;
create or replace view aggView6585785987838970937 as select id as v3 from info_type as it where info= 'bottom 10 rank';
create or replace view aggJoin7609034903787438965 as select v15, v28, v29 from aggJoin793553870736949522 join aggView6585785987838970937 using(v3);
create or replace view aggView6940737174226280833 as select v15, MIN(v28) as v28, MIN(v29) as v29 from aggJoin7609034903787438965 group by v15;
create or replace view aggJoin1508950563237260856 as select company_type_id as v1, note as v9, v28, v29 from movie_companies as mc, aggView6940737174226280833 where mc.movie_id=aggView6940737174226280833.v15 and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%';
create or replace view aggView4800984813212452069 as select v1, MIN(v28) as v28, MIN(v29) as v29, MIN(v9) as v27 from aggJoin1508950563237260856 group by v1;
create or replace view aggJoin3529795772919290839 as select kind as v2, v28, v29, v27 from company_type as ct, aggView4800984813212452069 where ct.id=aggView4800984813212452069.v1 and kind= 'production companies';
select MIN(v27) as v27,MIN(v28) as v28,MIN(v29) as v29 from aggJoin3529795772919290839;
