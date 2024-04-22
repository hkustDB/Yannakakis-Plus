create or replace view aggJoin6450833804209126158 as (
with aggView5154741538435364066 as (select id as v1, name as v43 from company_name as cn where country_code= '[us]')
select movie_id as v22, company_type_id as v8, v43 from movie_companies as mc, aggView5154741538435364066 where mc.company_id=aggView5154741538435364066.v1);
create or replace view aggJoin8951713085805325972 as (
with aggView211218465554134615 as (select id as v8 from company_type as ct where kind= 'production companies')
select v22, v43 from aggJoin6450833804209126158 join aggView211218465554134615 using(v8));
create or replace view aggJoin631286315046137134 as (
with aggView66896035352836585 as (select id as v12 from info_type as it2 where info= 'release dates')
select movie_id as v22 from movie_info as mi, aggView66896035352836585 where mi.info_type_id=aggView66896035352836585.v12);
create or replace view aggJoin1792554306756171111 as (
with aggView2371282089317889447 as (select id as v10 from info_type as it where info= 'rating')
select movie_id as v22, info as v29 from movie_info_idx as miidx, aggView2371282089317889447 where miidx.info_type_id=aggView2371282089317889447.v10);
create or replace view aggJoin1791870171688273449 as (
with aggView2712423188916580858 as (select v22, MIN(v29) as v44 from aggJoin1792554306756171111 group by v22)
select v22, v44 from aggJoin631286315046137134 join aggView2712423188916580858 using(v22));
create or replace view aggJoin1042866630002658843 as (
with aggView467517074801181060 as (select id as v14 from kind_type as kt where kind= 'movie')
select id as v22, title as v32 from title as t, aggView467517074801181060 where t.kind_id=aggView467517074801181060.v14 and title<> '' and ((title LIKE '%Champion%') OR (title LIKE '%Loser%')));
create or replace view aggJoin7566317852994361944 as (
with aggView7518656078678280709 as (select v22, MIN(v32) as v45 from aggJoin1042866630002658843 group by v22)
select v22, v43 as v43, v45 from aggJoin8951713085805325972 join aggView7518656078678280709 using(v22));
create or replace view aggJoin9097595207781969614 as (
with aggView310231372307569700 as (select v22, MIN(v43) as v43, MIN(v45) as v45 from aggJoin7566317852994361944 group by v22,v43,v45)
select v44 as v44, v43, v45 from aggJoin1791870171688273449 join aggView310231372307569700 using(v22));
select MIN(v43) as v43,MIN(v44) as v44,MIN(v45) as v45 from aggJoin9097595207781969614;
