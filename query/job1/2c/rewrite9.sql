create or replace view aggView7307260234339258368 as select id as v1 from company_name as cn where country_code= '[sm]';
create or replace view aggJoin9152545553393978317 as select movie_id as v12 from movie_companies as mc, aggView7307260234339258368 where mc.company_id=aggView7307260234339258368.v1;
create or replace view aggView2643287614631636900 as select v12 from aggJoin9152545553393978317 group by v12;
create or replace view aggJoin2046086656706758317 as select movie_id as v12, keyword_id as v18 from movie_keyword as mk, aggView2643287614631636900 where mk.movie_id=aggView2643287614631636900.v12;
create or replace view aggView3598343313403394332 as select id as v18 from keyword as k where keyword= 'character-name-in-title';
create or replace view aggJoin5835063062074183099 as select v12 from aggJoin2046086656706758317 join aggView3598343313403394332 using(v18);
create or replace view aggView4317452624288979657 as select v12 from aggJoin5835063062074183099 group by v12;
create or replace view aggJoin2848591796167815171 as select title as v20 from title as t, aggView4317452624288979657 where t.id=aggView4317452624288979657.v12;
select MIN(v20) as v31 from aggJoin2848591796167815171;
