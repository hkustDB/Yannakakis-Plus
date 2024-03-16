create or replace view aggView7502410534439541211 as select id as v3 from info_type as it;
create or replace view aggJoin3625251767325179157 as select movie_id as v15, info as v13 from movie_info as mi, aggView7502410534439541211 where mi.info_type_id=aggView7502410534439541211.v3 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German');
create or replace view aggView4874217677680214317 as select v15 from aggJoin3625251767325179157 group by v15;
create or replace view aggJoin6787344673441688041 as select id as v15, title as v16 from title as t, aggView4874217677680214317 where t.id=aggView4874217677680214317.v15 and production_year>2005;
create or replace view aggView2723983762228832513 as select v15, MIN(v16) as v27 from aggJoin6787344673441688041 group by v15;
create or replace view aggJoin4589312103214966802 as select company_type_id as v1, v27 from movie_companies as mc, aggView2723983762228832513 where mc.movie_id=aggView2723983762228832513.v15 and note LIKE '%(theatrical)%' and note LIKE '%(France)%';
create or replace view aggView3286813457436234127 as select v1, MIN(v27) as v27 from aggJoin4589312103214966802 group by v1;
create or replace view aggJoin8415804318686054756 as select v27 from company_type as ct, aggView3286813457436234127 where ct.id=aggView3286813457436234127.v1 and kind= 'production companies';
select MIN(v27) as v27 from aggJoin8415804318686054756;
