create or replace view aggView3034541460231095388 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin4574883893716512746 as select movie_id as v15, note as v9 from movie_companies as mc, aggView3034541460231095388 where mc.company_type_id=aggView3034541460231095388.v1 and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%';
create or replace view aggView8588584891274596519 as select v15, MIN(v9) as v27 from aggJoin4574883893716512746 group by v15;
create or replace view aggJoin5489532862962385878 as select id as v15, title as v16, production_year as v19, v27 from title as t, aggView8588584891274596519 where t.id=aggView8588584891274596519.v15 and production_year>2000;
create or replace view aggView8972386973181452621 as select v15, MIN(v27) as v27, MIN(v16) as v28, MIN(v19) as v29 from aggJoin5489532862962385878 group by v15;
create or replace view aggJoin6208181134737929029 as select info_type_id as v3, v27, v28, v29 from movie_info_idx as mi_idx, aggView8972386973181452621 where mi_idx.movie_id=aggView8972386973181452621.v15;
create or replace view aggView3699403818740975723 as select id as v3 from info_type as it where info= 'bottom 10 rank';
create or replace view aggJoin1658213849769810755 as select v27, v28, v29 from aggJoin6208181134737929029 join aggView3699403818740975723 using(v3);
select MIN(v27) as v27,MIN(v28) as v28,MIN(v29) as v29 from aggJoin1658213849769810755;
