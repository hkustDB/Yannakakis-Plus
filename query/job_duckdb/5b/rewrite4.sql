create or replace view aggView1248072319953348817 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin3731370465484363833 as select movie_id as v15, note as v9 from movie_companies as mc, aggView1248072319953348817 where mc.company_type_id=aggView1248072319953348817.v1 and note LIKE '%(USA)%' and note LIKE '%(VHS)%' and note LIKE '%(1994)%';
create or replace view aggView7186519942344888682 as select id as v15, title as v27 from title as t where production_year>2010;
create or replace view aggJoin2479867109727944301 as select v15, v9, v27 from aggJoin3731370465484363833 join aggView7186519942344888682 using(v15);
create or replace view aggView2429036829886240760 as select id as v3 from info_type as it;
create or replace view aggJoin7058016989737537685 as select movie_id as v15, info as v13 from movie_info as mi, aggView2429036829886240760 where mi.info_type_id=aggView2429036829886240760.v3 and info IN ('USA','America');
create or replace view aggView7921978141504164720 as select v15, MIN(v27) as v27 from aggJoin2479867109727944301 group by v15,v27;
create or replace view aggJoin3150134753758528184 as select v27 from aggJoin7058016989737537685 join aggView7921978141504164720 using(v15);
select MIN(v27) as v27 from aggJoin3150134753758528184;
