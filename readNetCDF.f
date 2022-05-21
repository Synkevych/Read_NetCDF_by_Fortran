      PROGRAM readNetCDF
      implicit none
      include 'netcdf.inc'

      CHARACTER*60 fname
      integer imx
      parameter(imx=1000000)
      real arr(imx)

      integer retval,ncid,varid

      fname='geo_em.d01.nc'
C     Open the file. NF_NOWRITE tells netCDF we want read-only access to
C     the file.
      retval = nf_open(fname, NF_NOWRITE, ncid)
      if (retval .ne. nf_noerr) call handle_err(retval)

C     Get the varid of the data variable, based on its name.
      retval = nf_inq_varid(ncid, 'XLAT_M', varid)

C     Read the data.
      retval = nf_get_var_real(ncid, varid, arr)
      if (retval .ne. nf_noerr) call handle_err(retval)

c     Print data (119*79=west_east*south_north - actual dimensity of XLAT_M array)
      print *,arr(1:119*79)
      end

C################################################################
C     subroutine handle_err: for identefication error in libriary
C                            "netcdf.inc"
C################################################################

      subroutine handle_err(errcode)
      implicit none
      include 'netcdf.inc'
      integer errcode

      print *, 'Error: ', nf_strerror(errcode)
      stop
      end
