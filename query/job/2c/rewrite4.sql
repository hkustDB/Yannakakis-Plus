create or replace view aggView5246646864794343148 as select id as v1 from company_name as cn where country_code= '[sm]';
create or replace view aggJoin6782647153709836010 as select movie_id as v12 from movie_companies as mc, aggView5246646864794343148 where mc.company_id=aggView5246646864794343148.v1;
create or replace view aggView4394663273914284220 as select v12 from aggJoin6782647153709836010 group by v12;
create or replace view aggJoin8785641355106320295 as select id as v12, title as v20 from title as t, aggView4394663273914284220 where t.id=aggView4394663273914284220.v12;
create or replace view aggView7683261315489484587 as select v12, MIN(v20) as v31 from aggJoin8785641355106320295 group by v12;
create or replace view aggJoin4945905444746617244 as select keyword_id as v18, v31 from movie_keyword as mk, aggView7683261315489484587 where mk.movie_id=aggView7683261315489484587.v12;
create or replace view aggView4132998290440232120 as select id as v18 from keyword as k where keyword= 'character-name-in-title';
create or replace view aggJoin354609257086926001 as select v31 from aggJoin4945905444746617244 join aggView4132998290440232120 using(v18);
select MIN(v31) as v31 from aggJoin354609257086926001;
